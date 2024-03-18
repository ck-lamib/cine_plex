import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cine_plex/controller/movies/movie_controller.dart';
import 'package:cine_plex/utils/colors.dart';
import 'package:cine_plex/utils/date_time_helper.dart';
import 'package:cine_plex/widgets/row/details_row.dart';

class MovieDetailScreen extends StatelessWidget {
  final c = Get.find<MovieController>();
  MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              c.movie.value?.description ?? "",
              style: textTheme.bodyMedium!,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Information",
              style: textTheme.titleMedium!
                  .copyWith(color: AppColors.hintTextColor),
            ),
            const SizedBox(
              height: 8,
            ),
            DetailRow(
              title: "Duration",
              value: DateTimeHelper.toDuration(c.movie.value!.duration!),
            ),
            DetailRow(
              title: "Release Date",
              value: DateTimeHelper.dateWithYear(
                  DateTime.parse(c.movie.value!.releaseDate!)),
            )
          ],
        ),
      ),
    );
  }
}
