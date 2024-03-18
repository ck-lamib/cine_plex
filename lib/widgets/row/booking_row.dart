import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cine_plex/model/booking.dart';
import 'package:cine_plex/utils/colors.dart';
import 'package:cine_plex/utils/date_time_helper.dart';
import 'package:cine_plex/utils/image_path.dart';
import 'package:cine_plex/views/booking/booking_details.dart';

class BookingRow extends StatelessWidget {
  const BookingRow({
    super.key,
    required this.booking,
  });

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return InkWell(
      onTap: () {
        Get.toNamed(BookingDetailScreen.routeName, arguments: [booking]);
      },
      child: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppColors.onBackGroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: booking.movie?.imageUrl ?? "",
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Image.asset(ImagePath.placeholder),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${booking.movie!.title!} ${getStatus()}",
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      DateTimeHelper.toDuration(booking.movie!.duration!),
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${booking.vendor!.name!} (${booking.vendor!.address ?? "No address"})",
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      DateTimeHelper.prettyDateWithDayTime(
                          DateTime.parse(booking.showTime!)),
                      style: textTheme.titleMedium,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getStatus() {
    if (booking.status == "Paid") {
      return "(Booked)";
    } else if (booking.status == "Unpaid") {
      return "(Reserved)";
    } else {
      return "(---)";
    }
  }
}
