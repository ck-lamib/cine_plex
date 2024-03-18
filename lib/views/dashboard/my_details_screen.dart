import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cine_plex/controller/dashboard/my_details_controller.dart';
import 'package:cine_plex/utils/image_path.dart';
import 'package:cine_plex/utils/validators.dart';
import 'package:cine_plex/widgets/custom/custom_elevated_button.dart';
import 'package:cine_plex/widgets/custom/custome_textfield.dart';

class MyDetailsScreen extends StatelessWidget {
  static const String routeName = "/my-details";
  final c = Get.find<MyDetailsController>();
  MyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: c.formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: (c.image.value != null)
                        ? Image.file(
                            c.image.value!,
                            fit: BoxFit.cover,
                            height: 120,
                            width: 120,
                          )
                        : CachedNetworkImage(
                            imageUrl: c.user.value?.profileImageUrl ?? "",
                            fit: BoxFit.cover,
                            height: 120,
                            width: 120,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Image.asset(
                              ImagePath.placeholder,
                              fit: BoxFit.cover,
                              height: 120,
                              width: 120,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: c.pickImage,
                  child: const Center(
                    child: Text(
                      "Upload Image",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomTextField(
                  controller: c.nameController,
                  hint: "Full Name",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  validator: Validators.checkFieldEmpty,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: c.emailController,
                  hint: "Email",
                  fillColor: Colors.white70,
                  readOnly: true,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  validator: Validators.checkFieldEmpty,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: c.phoneController,
                  hint: "Phone",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  validator: Validators.checkOptionalPhoneField,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomElevatedButton(
                  title: "Update",
                  onTap: c.submit,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
