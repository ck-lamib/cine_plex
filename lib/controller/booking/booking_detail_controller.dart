import 'dart:developer';

import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:cine_plex/model/booking.dart';
import 'package:cine_plex/model/seats.dart';
import 'package:cine_plex/repo/booking/booking_repo.dart';
import 'package:cine_plex/utils/colors.dart';
import 'package:cine_plex/utils/custom_snackbar.dart';
import 'package:cine_plex/views/dashboard/dashscreen.dart';

class BookingDetailController extends GetxController {
  Rxn<Booking> booking = Rxn<Booking>();
  RxList<Seat> seats = RxList<Seat>();

  RxBool isLoading = RxBool(false);

  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);

  @override
  void onInit() {
    var data = Get.arguments;

    booking.value = data[0];
    log("Booking details ====> ${booking.value?.toJson()}");
    getBookingDetails();
    super.onInit();
  }

  void getBookingDetails() async {
    isLoading.value = true;

    await BookingRepo.getBookingDetails(
      bookingId: booking.value!.id!,
      onSuccess: (booking, seats) {
        this.booking.value = booking;
        this.seats.addAll(seats);
        isLoading.value = false;
      },
      onError: (message) {
        isLoading.value = false;
        CustomSnackBar.error(message: message);
      },
    );
  }

  String getStatus() {
    if (booking.value!.status! == "Paid") {
      return "Booked";
    } else if (booking.value!.status! == "Unpaid") {
      return "Reserved";
    } else {
      return "---";
    }
  }

  String getSetsName() {
    String seatString = "";
    for (var seat in seats) {
      seatString += "${seat.seatName} \n\n";
    }
    return seatString.trim();
  }

  String getTicketNumber() {
    String ticektString = "";
    for (var seat in seats) {
      ticektString += "${seat.ticketNumber ?? ""} \n\n";
    }
    return ticektString.trim();
  }

  void cancelBooking() async {
    loading.show(
        message: "PLease wiat ..", backgroundColor: AppColors.backGroundColor);

    await BookingRepo.cancelBooking(
      bookingId: booking.value!.id!,
      onSuccess: (message) {
        loading.hide();
        Get.offNamedUntil(DashScreen.routeName,
            (route) => route.settings.name == DashScreen.routeName);
        CustomSnackBar.success(message: message);
      },
      onError: (message) {
        loading.hide();
        CustomSnackBar.error(message: message);
      },
    );
  }
}
