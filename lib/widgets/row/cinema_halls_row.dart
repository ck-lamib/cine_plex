import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cine_plex/model/halls.dart';
import 'package:cine_plex/utils/colors.dart';
import 'package:cine_plex/utils/image_path.dart';
import 'package:cine_plex/views/cinema_hall_screen.dart';

class CinemaHallRow extends StatelessWidget {
  final CinemaHalls cinemaHall;
  const CinemaHallRow({
    super.key,
    required this.cinemaHall,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return InkWell(
      onTap: () {
        Get.toNamed(CinemaHallScreen.routeName, arguments: [cinemaHall]);
      },
      child: Container(
        width: Get.width,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: AppColors.backGroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(1, 1),
                  blurRadius: 8,
                  spreadRadius: 1,
                  color: Colors.white.withOpacity(0.2))
            ]),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withOpacity(0.8),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    imageUrl: cinemaHall.imageUrl ?? "",
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Image.asset(ImagePath.placeholder),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${cinemaHall.name}",
                    style: textTheme.titleLarge,
                    maxLines: 2,
                  ),
                  Text(
                    cinemaHall.address ?? "No Location",
                    maxLines: 1,
                    style: textTheme.titleMedium,
                  ),
                  Text(
                    cinemaHall.phone ?? "No Contact",
                    maxLines: 1,
                    style: textTheme.titleMedium,
                  ),
                  Text(
                    "${cinemaHall.email}",
                    maxLines: 1,
                    style: textTheme.titleMedium!.copyWith(color: Colors.blue),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
