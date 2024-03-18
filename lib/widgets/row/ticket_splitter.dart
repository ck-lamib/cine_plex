import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cine_plex/utils/colors.dart';
import 'package:cine_plex/widgets/dotted_line.dart';

class TicketSplitter extends StatelessWidget {
  const TicketSplitter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 18,
            width: 9,
            decoration: const BoxDecoration(
                color: AppColors.backGroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                )),
          ),
          HorizontalDottedLine(
            width: Get.width - 58,
          ),
          Container(
            height: 18,
            width: 9,
            decoration: const BoxDecoration(
                color: AppColors.backGroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                )),
          )
        ],
      ),
    );
  }
}
