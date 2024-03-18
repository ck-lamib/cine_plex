import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:cine_plex/model/movies.dart';
import 'package:cine_plex/model/seats.dart';
import 'package:cine_plex/model/theaters.dart';
import 'package:cine_plex/repo/booking/booking_repo.dart';
import 'package:cine_plex/repo/movies/seats_repo.dart';
import 'package:cine_plex/utils/colors.dart';
import 'package:cine_plex/utils/custom_snackbar.dart';
import 'package:cine_plex/utils/date_time_helper.dart';
import 'package:cine_plex/views/booking/booking_details.dart';
import 'package:cine_plex/views/dashboard/dashscreen.dart';
import 'package:cine_plex/views/payment_screen.dart';

class TheaterController extends GetxController {
  Rxn<Movie> movie = Rxn<Movie>();
  Rxn<Show> show = Rxn<Show>();
  Rxn<Theaters> theater = Rxn<Theaters>();
  RxList<Seat> seats = RxList<Seat>();

  RxString title = RxString("Loading ..");
  RxString subTitle = RxString("Loading ..");
  RxBool isLoading = RxBool(false);

  RxList<int> selectedSeats = RxList<int>();

  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);

  @override
  void onInit() {
    var data = Get.arguments;

    movie.value = data[0];
    show.value = data[1];

    title.value = movie.value!.title!;
    subTitle.value =
        "${DateTimeHelper.dateWithYear(DateTime.parse(show.value!.showDate!))} ${DateTimeHelper.toTimeofDay(show.value!.showTime!).format(Get.context!)}";
    getSeats();
    super.onInit();
  }

  void getSeats() async {
    isLoading.value = true;

    await SeatsRepo.getSeats(
      showId: show.value!.showTimeId!,
      showDate: show.value!.showDate!,
      showTime: show.value!.showTime!,
      showPrice: show.value!.ticketPrice!,
      theaterId: movie.value!.theaterId!,
      onSuccess: (theater, seats) {
        this.theater.value = theater;
        this.seats.addAll(seats);
        isLoading.value = false;
      },
      onError: (message) {
        CustomSnackBar.error(message: message, title: "Show details");
      },
    );
  }

  void buyTicket() async {
    if (selectedSeats.isNotEmpty) {
      bookSeats("book");
    } else {
      CustomSnackBar.error(
          title: "Book Ticket", message: "Please select seats to proceed");
    }
  }

  void reserveSeats() async {
    if (selectedSeats.isNotEmpty) {
      bookSeats("reserve");
    } else {
      CustomSnackBar.error(
          title: "Reserve Seats", message: "Please select seats to proceed");
    }
  }

  void bookSeats(String type) async {
    loading.show(
        message: "PLease wiat ..", backgroundColor: AppColors.backGroundColor);

    await BookingRepo.bookSeats(
      type: type,
      vendorId: movie.value!.vendorId!,
      theaterId: theater.value!.id!,
      movieId: movie.value!.id!,
      showTimeId: show.value!.showTimeId!,
      showDate: show.value!.showDate!,
      showTime: show.value!.showTime!,
      showPrice: show.value!.ticketPrice!,
      seats: selectedSeats,
      onSuccess: (booking, seats, type) {
        loading.hide();
        if (type.toLowerCase() == "book") {
          Get.offNamedUntil(DashScreen.routeName,
              (route) => route.settings.name == DashScreen.routeName);
          Get.toNamed(PaymentScreen.routeName, arguments: [booking]);
        } else {
          Get.offNamedUntil(DashScreen.routeName,
              (route) => route.settings.name == DashScreen.routeName);
          Get.offNamed(BookingDetailScreen.routeName,
              arguments: [booking, seats]);
          CustomSnackBar.success(
              title: "Seats Reserved",
              message: "Seats have been reserved succesfully");
        }
      },
      onError: (message) {
        loading.hide();
        CustomSnackBar.error(message: message);
      },
    );
  }

  void selectSeat(int seatId) {
    if (selectedSeats.contains(seatId)) {
      selectedSeats.remove(seatId);
    } else {
      selectedSeats.add(seatId);
    }
  }
}
