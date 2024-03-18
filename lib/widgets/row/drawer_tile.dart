import 'package:flutter/material.dart';
import 'package:cine_plex/utils/colors.dart';

class DrawerTile extends StatelessWidget {
  final Color? color;
  final bool showTrailing;
  final String title;
  final IconData leadingIcon;
  final VoidCallback onTap;
  const DrawerTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
    this.color,
    this.showTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return ListTile(
      onTap: onTap,
      leading: Icon(
        leadingIcon,
        color: color ?? theme.colorScheme.primary,
      ),
      title: Text(
        title,
        style:
            textTheme.bodyMedium!.copyWith(color: color ?? AppColors.textColor),
      ),
    );
  }
}
