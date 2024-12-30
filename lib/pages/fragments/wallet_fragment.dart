import 'package:cowok/config/app_format.dart';
import 'package:cowok/config/color.dart';
import 'package:cowok/controllers/booking_controllers.dart';
import 'package:cowok/controllers/checkout_controller.dart';
import 'package:cowok/controllers/user_controller.dart';
import 'package:cowok/widgets/header_worker_left.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class WalletFragment extends StatefulWidget {
  const WalletFragment({super.key});

  @override
  State<WalletFragment> createState() => _WalletFragmentState();
}

class _WalletFragmentState extends State<WalletFragment> {
  final checkoutController = Get.put(CheckoutController());
  final bookingController = Get.put(BookingController());
  final userController = Get.put(UserController());

  @override
  void dispose() {
    checkoutController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          SizedBox(
            height: 172,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColor.bgHeader,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, 55),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeaderWorkerLeft(
                        title: 'Wallet',
                        subtitle: 'Start hiring and grow',
                        iconLeft: 'assets/ic_back.png',
                        functionLeft: () {
                        },
                      ),
                      payments(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(0, 60),
            child: walletBox(),
          ),      
          DView.spaceHeight(30),
          const Center(
            child: Text(
              'Read Terms & Conditions',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                decorationStyle: TextDecorationStyle.solid,
                fontSize: 16,
                color: Color(0xffB2B3BC),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget walletBox() {
  return Stack(
    children: [
      Image.asset(
        'assets/bg_card.png',
      ),
      Positioned(
        left: 60,
        top: 110,
        child: Obx(() {
          return Text(
            AppFormat.price(userController.walletBalance.value),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          );
        }),
      ),
      Positioned(
        left: 60,
        right: 60,
        bottom: 106,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              return Text(
                userController.data.name ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              );
            }),
            const Text(
              '12/27',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}


  Widget payments() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: checkoutController.payments.map((e) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                    color: e['is_active']
                        ? Theme.of(context).primaryColor
                        : const Color(0xffF2F2F2),
                  ),
                  child: Image.asset(
                    e['image'],
                  ),
                ),
                DView.spaceHeight(8),
                Text(
                  e['label'],
                  style: TextStyle(
                    color:
                        e['is_active'] ? Colors.black : const Color(0xffA7A8B3),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
