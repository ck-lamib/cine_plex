import 'package:flutter/material.dart';

import 'package:cine_plex/utils/colors.dart';
import 'package:cine_plex/utils/image_path.dart';

import '../utils/custom_text_styles.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ImagePath.noShows),
        Text(
          "No Data to show",
          style: CustomTextStyles.f24W600(color: AppColors.primaryColor),
        )
      ],
    );
  }
}
