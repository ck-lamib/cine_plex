import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cine_plex/utils/custom_snackbar.dart';
import 'package:cine_plex/utils/date_time_helper.dart';
import 'package:cine_plex/views/movie/theater_screen.dart';
import 'package:cine_plex/widgets/selection_buttion.dart';

import '../../controller/movies/movie_controller.dart';

class ShowDetailScreen extends StatelessWidget {
  final c = Get.find<MovieController>();
  ShowDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Date",
            style: textTheme.titleLarge,
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: c.showDates.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => SelectionButton(
                    isDisabled: false,
                    title: DateTimeHelper.dateMonth(
                        DateTime.parse(c.showDates[index])),
                    isActive: c.selectedDate.value == c.showDates[index],
                    onTap: () {
                      c.selectShowDate(c.showDates[index]);
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Select Time",
            style: textTheme.titleLarge,
          ),
          const SizedBox(
            height: 12,
          ),
          Obx(() => SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: c.shows[c.selectedDate.value]!.length,
                  itemBuilder: (context, index) {
                    var show = c.shows[c.selectedDate.value]![index];
                    return SelectionButton(
                      title: DateTimeHelper.toTimeofDay(show.showTime!)
                          .format(context),
                      isActive: false,
                      isDisabled: !isAvailable(show.showTime!),
                      onTap: () {
                        if (isAvailable(show.showTime!)) {
                          Get.toNamed(TheaterScreen.routeName,
                              arguments: [c.movie.value, show]);
                          c.videoPlayerController.pause();
                        }
                      },
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }

  bool isAvailable(String timeString) {
    log("${DateTimeHelper.toTimeofDay(timeString).compareTo(TimeOfDay.now())} ============> Time Comparision");
    if (DateTimeHelper.isSameDate(
        DateTime.now(), DateTime.parse(c.selectedDate.value))) {
      if (DateTimeHelper.toTimeofDay(timeString).compareTo(TimeOfDay.now()) ==
          -1) {
        return false;
      }
    }
    return true;
  }
}
