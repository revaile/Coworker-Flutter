import 'package:cowok/config/enum.dart';
import 'package:cowok/controllers/list_worker_controller.dart';
import 'package:cowok/controllers/worker_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessBookingController extends GetxController {
  clear() {
    Get.delete<SuccessBookingController>(force: true);
  }

  toWorkerProfile(BuildContext context, String workerId, String category) {
    final workerProfileController = Get.put(WorkerProfileController());
    workerProfileController.checkHiredBy(workerId);
    final listWorkerController = Get.put(ListWorkerController());
    listWorkerController.fetchAvailable(category);
    Navigator.popUntil(
      context,
      (route) => route.settings.name == AppRoute.workerProfile.name,
    );
  }

  toListWorker(BuildContext context, String category) {
    final listWorkerController = Get.put(ListWorkerController());
    listWorkerController.fetchAvailable(category);
    Navigator.popUntil(
      context,
      (route) => route.settings.name == AppRoute.listWorker.name,
    );
  }
}
