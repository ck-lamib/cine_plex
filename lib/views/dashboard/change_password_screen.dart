import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cine_plex/utils/validators.dart';
import 'package:cine_plex/widgets/custom/custom_elevated_button.dart';
import 'package:cine_plex/widgets/custom/custome_passwordfiled.dart';

import '../../controller/dashboard/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const String routeName = "/change-password";
  final c = Get.find<ChangePasswordController>();
  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: c.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: Get.height / 1.2,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(
                    () => CustomPasswordField(
                        hint: "Old Password",
                        eye: c.oldPassEye.value,
                        onEyeClick: c.onOldEyeClick,
                        controller: c.oldPassCon,
                        textInputAction: TextInputAction.next),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => CustomPasswordField(
                        hint: "New Password",
                        eye: c.newPassEye.value,
                        onEyeClick: c.onNewEyeClick,
                        controller: c.newPassCon,
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
                        controller: c.confirmPassCon,
                        validator: (fieldContent) {
                          return Validators.checkConfirmPassword(
                              c.newPassCon.text, fieldContent);
                        },
                        textInputAction: TextInputAction.done),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Spacer(),
                  CustomElevatedButton(
                    title: "Change Password",
                    onTap: c.onSubmit,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
