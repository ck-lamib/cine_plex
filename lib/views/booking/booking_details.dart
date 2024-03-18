import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cine_plex/controller/booking/booking_detail_controller.dart';
import 'package:cine_plex/utils/colors.dart';
import 'package:cine_plex/utils/custom_text_styles.dart';
import 'package:cine_plex/utils/date_time_helper.dart';
import 'package:cine_plex/utils/image_path.dart';
import 'package:cine_plex/utils/price_helper.dart';
import 'package:cine_plex/views/dashboard/dashscreen.dart';
import 'package:cine_plex/views/payment_screen.dart';
import 'package:cine_plex/widgets/custom/custom_elevated_button.dart';
import 'package:cine_plex/widgets/row/date_row_value.dart';
import 'package:cine_plex/widgets/row/details_row.dart';
import 'package:cine_plex/widgets/row/ticket_splitter.dart';

import '../../widgets/dotted_line.dart';

class BookingDetailScreen extends StatelessWidget {
  static const String routeName = "/booking-detail";
  final c = Get.find<BookingDetailController>();
  BookingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("${c.booking.value?.movie?.title}"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (c.isLoading.value) {
          return const LinearProgressIndicator();
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 60),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.onBackGroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "${c.booking.value?.movie?.title}",
                          style: textTheme.titleLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Duration",
                              style: CustomTextStyles.f12W400(
                                  color: AppColors.hintTextColor),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              DateTimeHelper.toDuration(
                                  c.booking.value!.movie!.duration!),
                              style: CustomTextStyles.f12W600(
                                  color: AppColors.primaryColor),
                            )
                          ],
                        ),
                      ),
                      const TicketSplitter(),
                      DataRowValue(
                        title1: "Date",
                        title2: "Theater",
                        data1: DateTimeHelper.prettyDateWithDayTime(
                            DateTime.parse(c.booking.value!.showTime!)),
                        data2: "${c.booking.value?.theater?.name}",
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      DataRowValue(
                        title1: "Type",
                        data1: c.getStatus(),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      DataRowValue(
                        title1: "Seats",
                        title2: "Ticket Number",
                        data1: c.getSetsName(),
                        data2: c.getTicketNumber(),
                      ),
                      const TicketSplitter(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${c.booking.value?.vendor?.name}",
                                  style: textTheme.titleMedium,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  c.booking.value?.vendor?.address ??
                                      "No details",
                                  style: textTheme.titleSmall!
                                      .copyWith(color: AppColors.hintTextColor),
                                ),
                              ],
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl:
                                    c.booking.value?.vendor?.imageUrl ?? "",
                                height: 50,
                                fit: BoxFit.contain,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  ImagePath.placeholder,
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: HorizontalDottedLine(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: DetailRow(
                            title: "Total",
                            value: c.booking.value!.total!.toPrice()),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (c.booking.value?.status == "Unpaid")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomElevatedButton(
                      title: "Book Ticket",
                      onTap: () {
                        Get.offNamedUntil(
                            PaymentScreen.routeName,
                            (route) =>
                                route.settings.name == DashScreen.routeName,
                            arguments: [c.booking.value]);
                      },
                      backGroundColor: Colors.blue,
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomElevatedButton(
                    title: "Cancel",
                    onTap: c.cancelBooking,
                  ),
                )
              ],
            ),
          );
        }
      }),
    );
  }
}
