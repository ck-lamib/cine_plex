import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:cine_plex/controller/core_controller.dart';
import 'package:cine_plex/model/user.dart';
import 'package:cine_plex/repo/update_profile_repo.dart';
import 'package:cine_plex/utils/custom_snackbar.dart';
import 'package:cine_plex/utils/storage_helper.dart';

class MyDetailsController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final coreController = Get.find<CoreController>();

  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);
  final picker = ImagePicker();

  Rxn<User> user = Rxn<User>();
  Rxn<File> image = Rxn<File>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void onInit() {
    loadUser();
    super.onInit();
  }

  void loadUser() {
    user.value = coreController.currentUser.value;
    nameController.text = user.value?.name ?? "";
    phoneController.text = user.value?.phone ?? "";
    emailController.text = user.value?.email ?? "";
  }

  void pickImage() async {
    log("Picking image");
    final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
        maxHeight: 500,
        maxWidth: 500);

    if (pickedImage != null) {
      image.value = File(pickedImage.path);
    }
  }

  String? getImageString() {
    if (image.value == null) return null;

    final bytes = File(image.value!.path).readAsBytesSync();
    String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
    return base64Image;
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      loading.show(message: "Please wait ..");

      await UpdateProfileRepo.updateProfile(
        image: getImageString(),
        name: nameController.text,
        phone: phoneController.text,
        onSuccess: (user, message) async {
          loading.hide();
          final box = GetStorage();
          await box.write(StorageKeys.USER, json.encode(user.toJson()));
          coreController.loadCurrentUser();
          Get.back();
          CustomSnackBar.success(title: "Update Profile", message: message);
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Update Profile", message: message);
        },
      );
    }
  }
}
