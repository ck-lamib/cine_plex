import 'package:flutter/material.dart';
import 'package:cine_plex/utils/colors.dart';

class SelectionButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final bool isDisabled;
  final VoidCallback onTap;
  const SelectionButton({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: isDisabled
                ? Colors.transparent
                : isActive
                    ? Colors.white
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            border: isDisabled
                ? Border.all(color: AppColors.hintTextColor)
                : isActive
                    ? null
                    : Border.all(color: Colors.white)),
        child: Text(
          title,
          style: textTheme.titleMedium!.copyWith(
              color: isDisabled
                  ? AppColors.hintTextColor
                  : isActive
                      ? Colors.black
                      : Colors.white),
        ),
      ),
    );
  }
}
