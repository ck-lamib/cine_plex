import 'package:flutter/material.dart';
import 'package:cine_plex/utils/colors.dart';

ThemeData basicTheme() {
  return ThemeData.dark().copyWith(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backGroundColor,
      colorScheme: const ColorScheme.dark().copyWith(
          primary: AppColors.primaryColor,
          secondary: AppColors.primaryColor,
          background: AppColors.backGroundColor,
          onBackground: AppColors.onBackGroundColor,
          error: AppColors.errorColor));
}
