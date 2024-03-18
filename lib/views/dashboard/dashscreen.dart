import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cine_plex/controller/core_controller.dart';
import 'package:cine_plex/controller/dashboard/dash_controller.dart';
import 'package:cine_plex/utils/colors.dart';
import 'package:cine_plex/utils/image_path.dart';
import 'package:cine_plex/views/booking/bookings_seceen.dart';
import 'package:cine_plex/views/dashboard/change_password_screen.dart';
import 'package:cine_plex/views/dashboard/my_details_screen.dart';
import 'package:cine_plex/widgets/error_screen.dart';
import 'package:cine_plex/widgets/row/cinema_halls_row.dart';
import 'package:cine_plex/widgets/row/drawer_tile.dart';

class DashScreen extends StatelessWidget {
  static const String routeName = "/dashscreen";
  final c = Get.find<DashController>();
  final coreController = Get.find<CoreController>();
  DashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Theater"),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: theme.colorScheme.background,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: CachedNetworkImage(
                    imageUrl:
                        coreController.currentUser.value?.profileImageUrl ?? "",
                    fit: BoxFit.cover,
                    height: 120,
                    width: 120,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset(
                      ImagePath.placeholder,
                      fit: BoxFit.cover,
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => Text(
                  "${coreController.currentUser.value?.name}",
                  style: textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  height: 2,
                  thickness: 2,
                  color: theme.colorScheme.onBackground,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DrawerTile(
                onTap: () {
                  Get.back();
                  Get.toNamed(MyDetailsScreen.routeName);
                },
                leadingIcon: Icons.person_outline,
                title: "My Details",
                showTrailing: false,
              ),
              DrawerTile(
                onTap: () {
                  Get.back();
                  Get.toNamed(BookingsScreen.routeName);
                },
                leadingIcon: Icons.local_movies_outlined,
                title: "My Tickets",
                showTrailing: false,
              ),
              DrawerTile(
                onTap: () {
                  Get.back();
                  Get.toNamed(ChangePasswordScreen.routeName);
                },
                leadingIcon: Icons.key_outlined,
                title: "Change Passwords",
                showTrailing: false,
              ),
              DrawerTile(
                onTap: () {
                  Get.back();
                  coreController.logOut();
                },
                leadingIcon: Icons.logout,
                title: "Log out",
                color: AppColors.errorColor,
                showTrailing: false,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Obx(() {
            if (c.isLoading.value) {
              return const LinearProgressIndicator();
            } else if (!c.isLoading.value && c.halls.isEmpty) {
              return SizedBox(
                height: Get.height / 1.2,
                child: const ErrorScreen(),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemCount: c.halls.length,
                  itemBuilder: (context, index) {
                    var hall = c.halls[index];
                    return CinemaHallRow(
                      cinemaHall: hall,
                    );
                  },
                ),
              );
            }
          })
        ],
      ),
    );
  }
}
