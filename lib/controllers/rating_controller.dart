import 'package:cowok/controllers/worker_profile_controller.dart';
import 'package:cowok/datasources/booking_datasource.dart';
import 'package:cowok/datasources/worker_datasource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingController extends GetxController {
  var currentRating = 0.0.obs;
  var isSubmitting = false.obs;
  final WorkerProfileController workerProfileController =
      Get.put(WorkerProfileController());

  Future<void> submitRating(BuildContext context, String bookingId,
      String workerId, double newRating) async {
    try {
      isSubmitting.value = true;

      // Call the updateWorkerRating function from worker_datasource
      final result = await WorkerDatasource.updateWorkerRating(
        workerId: workerId,
        newRating: newRating,
      );

      result.fold(
        (failureMessage) {
          // If the update failed, show an error message
          Get.snackbar('Error', failureMessage,
              snackPosition: SnackPosition.BOTTOM);
        },
        (_) async {
          // If the update was successful, show a success message
          Get.snackbar('Success', 'Rating submitted successfully!',
              snackPosition: SnackPosition.BOTTOM);
          final setRatedResult = await BookingDatasource.setRated(
            bookingId,
            workerId,
          );

          setRatedResult.fold(
            (failureMessage) {
              // If setRated failed, show an error message
              Get.snackbar('Error', failureMessage,
                  snackPosition: SnackPosition.BOTTOM);
            },
            (_) {
              // If successful, show a success message
              Get.snackbar('Success', 'Rating submitted successfully!',
                  snackPosition: SnackPosition.BOTTOM);

              // Reset the rating and close the page
              currentRating.value = 0.0; // Reset rating to 0
              workerProfileController.checkHiredBy(workerId);
              Navigator.pop(context);
            },
          );
        },
      );
    } catch (e) {
      // In case of any errors during the rating submission
      Get.snackbar('Error', 'Failed to submit rating: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSubmitting.value = false;
    }
  }
}
