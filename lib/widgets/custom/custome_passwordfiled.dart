import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cine_plex/utils/colors.dart';
import 'package:cine_plex/utils/custom_text_styles.dart';
import 'package:cine_plex/utils/image_path.dart';
import 'package:cine_plex/utils/validators.dart';

class CustomPasswordField extends StatelessWidget {
  final String hint;
  final FocusNode? focusNode;
  final bool eye;
  final VoidCallback onEyeClick;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final Function(String)? onSubmitted;
  final double borderRadius;

  const CustomPasswordField({
    Key? key,
    required this.hint,
    required this.eye,
    required this.onEyeClick,
    required this.controller,
    required this.textInputAction,
    this.validator,
    this.onSubmitted,
    this.focusNode,
    this.borderRadius = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.backGroundColor,
      focusNode: focusNode,
      onFieldSubmitted: onSubmitted,
      controller: controller,
      validator: validator ?? Validators.checkPasswordField,
      obscureText: eye,
      maxLines: 1,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: const BorderSide(
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: const BorderSide(
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: const BorderSide(
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: const BorderSide(
            width: 1,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: onEyeClick,
          icon: (eye)
              ? SvgPicture.asset(
                  ImagePath.eyeOff,
                  height: 16,
                  colorFilter:
                      const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  fit: BoxFit.scaleDown,
                )
              : SvgPicture.asset(
                  ImagePath.eye,
                  height: 12,
                  colorFilter:
                      const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  fit: BoxFit.scaleDown,
                ),
        ),
        errorStyle: const TextStyle(fontSize: 12),
        hintText: hint,
        hintStyle: CustomTextStyles.f16W400(color: AppColors.hintTextColor),
      ),
      style: CustomTextStyles.f16W400(color: AppColors.backGroundColor),
    );
  }
}
