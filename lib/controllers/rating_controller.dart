
import 'package:get/get.dart';

class RatingController extends GetxController {
  var currentRating = 0.0.obs;
  var isSubmitting = false.obs;

  Future<void> submitRating(String workerId) async {
    try {
      isSubmitting.value = true;
      // Simulate API call or rating submission logic here
      await Future.delayed(const Duration(seconds: 2)); // Replace with actual API call
      // Success! Close the page
      Get.back(); // Close the current page
      Get.snackbar('Success', 'Rating submitted successfully!',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit rating: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSubmitting.value = false;
    }
  }
}

