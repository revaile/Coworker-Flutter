import 'package:cowok/datasources/worker_datasource.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';

class RatingController extends GetxController {
  var currentRating = 0.0.obs;
  var isSubmitting = false.obs;

  Future<void> submitRating(String workerId) async {
    isSubmitting.value = true;

    final result = await WorkerDatasource.updateWorkerRating(
      workerId: workerId,
      newRating: currentRating.value,
    );

    result.fold(
      (error) {
        Get.snackbar('Error', error, snackPosition: SnackPosition.BOTTOM);
      },
      (_) {
        Get.snackbar('Success', 'Thank you for your rating!',
            snackPosition: SnackPosition.BOTTOM);
        Get.back(); // Menutup halaman rating
      },
    );

    isSubmitting.value = false;
  }
}

