import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cine_plex/controller/auth/login_controller.dart';
import 'package:cine_plex/utils/colors.dart';
import 'package:cine_plex/utils/image_path.dart';
import 'package:cine_plex/utils/validators.dart';
import 'package:cine_plex/views/auth/forget_password_screen.dart';
import 'package:cine_plex/views/auth/signup_screen.dart';
import 'package:cine_plex/widgets/custom/custom_elevated_button.dart';
import 'package:cine_plex/widgets/custom/custome_passwordfiled.dart';
import 'package:cine_plex/widgets/custom/custome_textfield.dart';

import '../../utils/custom_text_styles.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/login-screen";
  final c = Get.find<LoginController>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: c.formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImagePath.logo,
                      height: Get.height / 3,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                        controller: c.emailController,
                        hint: "Email",
                        validator: Validators.checkEmailField,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.emailAddress),
                    const SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => CustomPasswordField(
                          hint: "Password",
                          eye: c.passwordObscure.value,
                          onEyeClick: c.onEyeCLick,
                          controller: c.passwordController,
                          textInputAction: TextInputAction.done),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomElevatedButton(
                      title: "Login",
                      onTap: c.onSubmit,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(ForgetPassworScreen.routeName);
                      },
                      child: Text(
                        "Forget Password?",
                        style: CustomTextStyles.f16W400(
                            color: AppColors.primaryColor),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not a member yet?",
                          style: CustomTextStyles.f16W400(
                            color: AppColors.hintTextColor,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.offNamed(SignupScreen.routeName);
                            },
                            child: Text(
                              "Sign Up Now",
                              style: CustomTextStyles.f16W400(
                                color: AppColors.primaryColor,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
