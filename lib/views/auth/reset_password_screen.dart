import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cine_plex/controller/auth/forget_password_controller.dart';
import 'package:cine_plex/utils/validators.dart';
import 'package:cine_plex/widgets/custom/custom_elevated_button.dart';
import 'package:cine_plex/widgets/custom/custome_passwordfiled.dart';
import 'package:cine_plex/widgets/custom/custome_textfield.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const String routeName = "/reset-password";
  final c = Get.find<ForgetPasswordController>();
  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        centerTitle: true,
      ),
      body: Form(
        key: c.resetFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  hint: "OTP",
                  validator: Validators.checkFieldEmpty,
                  controller: c.otpController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number),
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => CustomPasswordField(
                    hint: "New Password",
                    eye: c.newPassEye.value,
                    onEyeClick: c.onNewEyeClick,
                    controller: c.newPassController,
                    textInputAction: TextInputAction.next),
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => CustomPasswordField(
                    hint: "Confirm Password",
                    eye: c.confirmPassEye.value,
                    onEyeClick: c.onConfirmEyeClick,
                    controller: c.conPassController,
                    validator: (fieldContent) {
                      return Validators.checkConfirmPassword(
                          c.newPassController.text, fieldContent);
                    },
                    textInputAction: TextInputAction.done),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                title: "Continue",
                onTap: c.onResetPassword,
              )
            ],
          ),
        ),
      ),
    );
  }
}
