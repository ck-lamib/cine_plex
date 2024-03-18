import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cine_plex/utils/colors.dart';

class HorizontalDottedLine extends StatelessWidget {
  final double dashGap;
  final double dashHeight;
  final double dashWidth;
  final double? width;
  final Color color;
  const HorizontalDottedLine({
    super.key,
    this.dashGap = 5,
    this.dashHeight = 1,
    this.dashWidth = 5,
    this.color = AppColors.hintTextColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 0; i < (width ?? Get.width) / (dashGap + dashWidth); i++)
            Container(
              height: dashHeight,
              width: dashWidth,
              color: color,
            )
        ],
      ),
    );
  }
}
