import 'package:get/get.dart';
import 'package:cine_plex/model/halls.dart';
import 'package:cine_plex/repo/cinema_repo.dart';

class DashController extends GetxController {
  RxBool isLoading = RxBool(false);
  RxList<CinemaHalls> halls = RxList<CinemaHalls>();

  @override
  void onInit() {
    loadHalls();
    super.onInit();
  }

  void loadHalls() async {
    halls.clear();
    isLoading.value = true;

    await CinemaHallRepo.getCinemaHalls(
      onSuccess: (halls) {
        this.halls.addAll(halls);
        isLoading.value = false;
      },
      onError: (message) {
        isLoading.value = false;
      },
    );
  }
}
