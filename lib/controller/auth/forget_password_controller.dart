import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:cine_plex/repo/auth/forget_password_repo.dart';
import 'package:cine_plex/utils/custom_snackbar.dart';
import 'package:cine_plex/views/auth/login_screen.dart';
import 'package:cine_plex/views/auth/reset_password_screen.dart';

class ForgetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final resetFormKey = GlobalKey<FormState>();
  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);
  String? customerId;

  final emailController = TextEditingController();

  //Reset Password

  final newPassController = TextEditingController();
  final conPassController = TextEditingController();
  final otpController = TextEditingController();

  RxBool newPassEye = RxBool(true);
  RxBool confirmPassEye = RxBool(true);

  void onNewEyeClick() {
    newPassEye.value = !newPassEye.value;
  }

  void onConfirmEyeClick() {
    confirmPassEye.value = !confirmPassEye.value;
  }

  void onForgetPassword() async {
    if (formKey.currentState!.validate()) {
      loading.show(message: "PLease wiat ..");
      await ForgetPasswordRepo.forgetPassword(
        email: emailController.text,
        onSuccess: (customerId) {
          loading.hide();
          this.customerId = customerId;
          Get.toNamed(ResetPasswordScreen.routeName);
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Forget Password", message: message);
        },
      );
    }
  }

  void onResetPassword() async {
    if (formKey.currentState!.validate()) {
      loading.show(message: "PLease wiat ..");
      await ForgetPasswordRepo.resetPassword(
        customerId: customerId!,
        otp: otpController.text,
        password: newPassController.text,
        onSuccess: (message) async {
          loading.hide();
          Get.offAllNamed(LoginScreen.routeName);
          CustomSnackBar.success(title: "Reset Password", message: message);
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Reset Password", message: message);
        },
      );
    }
  }
}
