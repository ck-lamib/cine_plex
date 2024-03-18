import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cine_plex/model/movies.dart';
import 'package:cine_plex/utils/date_time_helper.dart';
import 'package:cine_plex/utils/image_path.dart';
import 'package:cine_plex/views/movie/movie_screen.dart';

import '../../utils/colors.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool showRightMargin;
  const MovieCard({
    super.key,
    required this.movie,
    this.showRightMargin = true,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return InkWell(
      onTap: () {
        Get.toNamed(MovieScreen.routeName, arguments: [movie]);
      },
      child: Container(
        width: (Get.width / 2) - 20,
        height: (Get.width / 2) + 40,
        margin: showRightMargin ? const EdgeInsets.only(right: 16) : null,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF252834)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: movie.image ?? "",
                width: (Get.width / 2) - 20,
                height: (Get.width / 2) + 10,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => Image.asset(
                  ImagePath.placeholder,
                  width: (Get.width / 2) - 20,
                  height: (Get.width / 2) + 10,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${movie.title}",
                    style: textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Release Date: ${DateTimeHelper.dateOnly(DateTime.parse(movie.releaseDate!))}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall!
                        .copyWith(color: AppColors.hintTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
