import 'package:cowok/controllers/booking_controllers.dart';
import 'package:cowok/widgets/secondary_button.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../config/app_format.dart';
import '../config/appwrite.dart';
import '../controllers/success_booking_controller.dart';

class SuccessBookingPage extends StatefulWidget {
  const SuccessBookingPage({super.key});

  @override
  State<SuccessBookingPage> createState() => _SuccessBookingPageState();
}

class _SuccessBookingPageState extends State<SuccessBookingPage> {
  final successBookingController = Get.put(SuccessBookingController());
  final bookingController = Get.put(BookingController());
  @override
  void dispose() {
    successBookingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/blur_purple.png'),
          Image.asset('assets/blur_blue.png'),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Success Hiring!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                DView.spaceHeight(10),
                const Text(
                  'Time to expand your business\nand grow confidently',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                DView.spaceHeight(50),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 6,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        Appwrite.imageURL(
                            bookingController.bookingDetail.worker!.image),
                        width: 136,
                        height: 136,
                        fit: BoxFit.cover,
                      ),
                    ),
                    hiredText(),
                  ],
                ),
                DView.spaceHeight(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      bookingController.bookingDetail.worker!.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    DView.spaceWidth(4),
                    Image.asset(
                      'assets/ic_verified.png',
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
                DView.spaceHeight(8),
                rating(),
                DView.spaceHeight(60),
                SizedBox(
                  width: 270,
                  child: FilledButton(
                    onPressed: () {
                      successBookingController.toWorkerProfile(
                        context,
                        bookingController.bookingDetail.workerId,
                        bookingController.bookingDetail.worker!.category,
                      );
                    },
                    child: const Text('Worker Profile'),
                  ),
                ),
                DView.spaceHeight(),
                SizedBox(
                  width: 270,
                  child: SecondaryButton(
                    onPressed: () {
                      successBookingController.toListWorker(
                        context,
                        bookingController.bookingDetail.worker!.category,
                      );
                    },
                    child: const Text('Hire other worker'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row rating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RatingBar.builder(
          initialRating: bookingController.bookingDetail.worker!.rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 20,
          itemPadding: const EdgeInsets.all(0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
          ignoreGestures: true,
        ),
        DView.spaceWidth(8),
        Text(
          '(${AppFormat.number(bookingController.bookingDetail.worker!.ratingCount)})',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget hiredText() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: Transform.translate(
          offset: const Offset(0, 6),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffBFA8FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'HIRED',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
