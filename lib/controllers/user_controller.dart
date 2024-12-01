import 'package:cowok/config/appwrite.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart'; // Pastikan package Appwrite diimpor
import '../models/user_model.dart';

class UserController extends GetxController {
  final _data = UserModel().obs;
  UserModel get data => _data.value;
  set data(UserModel n) => _data.value = n;

  Future<void> updateProfile({required String name, required String email}) async {
  try {
    // Perbarui email di akun Appwrite
    if (data.email != email) { // Hanya update jika email berubah
      await Appwrite.account.updateEmail(
        email: email,
        password: data.password!, // Password diperlukan untuk update email
      );
    }

    // Perbarui data di database
    await Appwrite.databases.updateDocument(
      databaseId: Appwrite.databaseId,
      collectionId: Appwrite.collectionUsers,
      documentId: data.$id!,
      data: {
        'name': name,
        'email': email,
      },
    );

    // Perbarui data lokal di controller
    data = UserModel(
      name: name,
      email: email,
      password: data.password,
      $id: data.$id,
      $createdAt: data.$createdAt,
      $updatedAt: DateTime.now().toIso8601String(),
    );

    Get.snackbar(
      'Success',
      'Profile updated successfully!',
      snackPosition: SnackPosition.BOTTOM,
    );
  } catch (e) {
    Get.snackbar(
      'Error',
      'Failed to update profile: $e',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

}
