import 'package:cowok/config/app_info.dart';
import 'package:cowok/config/enum.dart';
import 'package:cowok/datasources/booking_datasource.dart';
import 'package:cowok/models/booking_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  clear() {
    Get.delete<CheckoutController>(force: true);
  }

  final List<Map<String, dynamic>> payments = [
    {
      'image': 'assets/ic_wallet_payment.png',
      'label': 'Wallet',
      'is_active': true,
    },
  ];

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool n) => _loading.value = n;

  execute(BuildContext context, BookingModel bookingDetail) {
    loading = true;
    BookingDatasource.checkout(bookingDetail).then((value) {
      loading = false;
      value.fold(
        (message) => AppInfo.failed(context, message),
        (data) {
          Navigator.pushNamed(context, AppRoute.successBooking.name);
        },
      );
    });
  }
}
