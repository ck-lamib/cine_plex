import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cine_plex/controller/movies/theater_controller.dart';
import 'package:cine_plex/utils/colors.dart';
import 'package:cine_plex/utils/price_helper.dart';
import 'package:cine_plex/widgets/custom/custom_elevated_button.dart';
import 'package:cine_plex/widgets/dotted_line.dart';
import 'package:cine_plex/widgets/row/seat_widget.dart';
import 'package:zoom_widget/zoom_widget.dart';

class TheaterScreen extends StatelessWidget {
  static const String routeName = "/theater-screen";
  final c = Get.find<TheaterController>();
  TheaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Obx(
                () => Text(
                  c.title.value,
                  style: textTheme.titleLarge,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Obx(
                () => Text(
                  c.subTitle.value,
                  style: textTheme.titleSmall,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          if (c.isLoading.value) {
            return const LinearProgressIndicator();
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Theater: ${c.theater.value!.name}",
                  style: textTheme.titleLarge,
                ),
                SizedBox(
                  width: (c.theater.value!.columns! * 45) >= Get.width
                      ? Get.width
                      : (c.theater.value!.columns! * 45),
                  height: Get.height / 2,
                  child: Zoom(
                    backgroundColor: Colors.transparent,
                    canvasColor: Colors.transparent,
                    initTotalZoomOut: true,
                    child: SizedBox(
                      height: Get.height / 2,
                      width: (c.theater.value!.columns! * 45) >= Get.width
                          ? Get.width
                          : (c.theater.value!.columns! * 45),
                      child: GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: c.theater.value!.columns!,
                        ),
                        itemCount: c.seats.length,
                        itemBuilder: (context, index) {
                          var seat = c.seats[index];
                          return Obx(() => SeatWidget(
                                seat: seat,
                                onTap: () {
                                  c.selectSeat(seat.seatId!);
                                },
                                isSelected:
                                    c.selectedSeats.contains(seat.seatId),
                              ));
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                  child: Stack(
                    children: [
                      Center(
                          child: SizedBox(width: Get.width, child: Divider())),
                      Center(
                          child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        color: AppColors.backGroundColor,
                        child: Text(
                          "Screen",
                          style: textTheme.bodyLarge,
                        ),
                      )),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SeatDetailWidget(label: 'Available', color: Colors.green),
                      SizedBox(width: 16),
                      SeatDetailWidget(label: 'Selected', color: Colors.blue),
                      SizedBox(width: 16),
                      SeatDetailWidget(label: 'Reserved', color: Colors.orange),
                      SizedBox(width: 16),
                      SeatDetailWidget(label: 'Booked', color: Colors.grey),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(
                    color: AppColors.hintTextColor,
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Number of Seats",
                          style: textTheme.titleSmall,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 2,
                        child: Obx(
                          () => Text(
                            "${c.selectedSeats.length}",
                            style: textTheme.bodyMedium,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(
                    color: AppColors.hintTextColor,
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Total",
                          style: textTheme.titleSmall,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 2,
                        child: Obx(
                          () => Text(
                            (c.selectedSeats.length *
                                    c.show.value!.ticketPrice!)
                                .toPrice(),
                            style: textTheme.bodyMedium,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(
                    color: AppColors.hintTextColor,
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          title: "Buy",
                          onTap: c.buyTicket,
                          backGroundColor: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: CustomElevatedButton(
                          title: "Reserve",
                          onTap: c.reserveSeats,
                          backGroundColor: Colors.orange,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: CustomElevatedButton(
                          title: "Cancel",
                          onTap: () {
                            Get.back();
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            );
          }
        }));
  }
}

class SeatDetailWidget extends StatelessWidget {
  final Color color;
  final String label;
  const SeatDetailWidget({
    super.key,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
