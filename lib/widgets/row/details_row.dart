import 'package:flutter/material.dart';
import 'package:cine_plex/utils/colors.dart';

class DetailRow extends StatelessWidget {
  final String title;
  final String value;
  const DetailRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: textTheme.bodyLarge!.copyWith(
                color: AppColors.hintTextColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
