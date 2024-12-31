import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart'; // Import the controller

class EditeProfile extends StatelessWidget {
  const EditeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    final TextEditingController nameController =
        TextEditingController(text: userController.data.name ?? '');
    final TextEditingController emailController =
        TextEditingController(text: userController.data.email ?? '');

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'Edit Profile',
                middleText: 'Are you sure you want to update your profile?',
                textCancel: 'Cancel',
                textConfirm: 'Confirm',
                onCancel: () {
                  // Tutup dialog ketika "Cancel" ditekan
                  Get.back();
                  print('User canceled the update.');
                },
                onConfirm: () async {
                  // Tutup dialog terlebih dahulu
                  Get.back();
                  Navigator.pop(context);

                  try {
                    // Update data profile
                    await userController.updateProfile(
                      name: nameController.text,
                      email: emailController.text,
                    );

                    // Tampilkan snackbar jika berhasil
                    Get.snackbar(
                      'Success',
                      'Profile updated successfully!',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } catch (e) {
                    // Tampilkan snackbar jika gagal
                    Get.snackbar(
                      'Error',
                      'Failed to update profile: $e',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
              );
            },
            icon: const Icon(Icons.check, color: Colors.black),
          ),
        ],
      );
    }

    Widget content() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        margin: const EdgeInsets.only(top: 16.0),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 6,
                ),
                shape: BoxShape.circle,
                color: const Color(0xffBFA8FF),
              ),
              alignment: Alignment.center,
              child: Obx(() {
                String initialName = userController.data.name == null
                    ? ""
                    : userController.data.name!.substring(0, 1);
                return Text(
                  initialName,
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email Address'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: header(),
      body: content(),
    );
  }
}
