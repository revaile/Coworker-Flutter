import 'package:cowok/controllers/rating_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class RatingPage extends StatelessWidget {
  final String workerId;
  final RatingController controller = Get.put(RatingController());

  RatingPage({super.key, required this.workerId});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Give Me Rating'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'How was your experience?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Obx(() {
                return RatingBar.builder(
                  initialRating: controller.currentRating.value,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    controller.currentRating.value = rating;
                  },
                );
              }),
              const SizedBox(height: 24),
              Obx(() {
                return ElevatedButton(
                  onPressed: controller.isSubmitting.value
                      ? null
                      : () => controller.submitRating(context, workerId, controller.currentRating.value),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 12.0),
                  ),
                  child: controller.isSubmitting.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Submit',
                          style: TextStyle(fontSize: 20),
                        ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

