import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cine_plex/controller/cinemahall_controller.dart';
import 'package:cine_plex/widgets/error_screen.dart';

import '../widgets/row/movie_card.dart';

class CinemaHallScreen extends StatelessWidget {
  static const String routeName = "/cinemahall-screen";
  final c = Get.find<CinemaHallController>();
  CinemaHallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("${c.cinemaHall.value?.name}"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() {
            if (c.isLoading.value) {
              return const LinearProgressIndicator();
            } else if (!c.isLoading.value &&
                c.nowShowing.isEmpty &&
                c.commingSoon.isEmpty) {
              return SizedBox(
                  height: Get.height / 1.2, child: const ErrorScreen());
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (c.nowShowing.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Now Showing",
                          style: textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio:
                                ((Get.width / 2) - 20) / ((Get.width / 2) + 70),
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                          ),
                          itemCount: c.nowShowing.length,
                          itemBuilder: (context, index) {
                            var movie = c.nowShowing[index];
                            return MovieCard(
                              movie: movie,
                              showRightMargin: false,
                            );
                          },
                        ),
                      ],
                    ),
                  if (c.commingSoon.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Comming Soon",
                          style: textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: (Get.width / 2) + 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: c.commingSoon.length,
                            itemBuilder: (context, index) {
                              var movie = c.commingSoon[index];
                              return MovieCard(
                                movie: movie,
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
