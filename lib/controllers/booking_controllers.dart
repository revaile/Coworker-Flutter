
import 'package:cowok/models/booking_models.dart';
import 'package:cowok/models/worker_model.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  // Clear controller
  clear() {
    Get.delete<BookingController>(force: true);
  }

  final hourDuartion = [5, 10, 15, 25, 40, 100];

  final _duration = 10.obs;
  int get duration => _duration.value;

  setDuration(int n, double hourRate) {
  _duration.value = n;

  // Perhitungan ulang
  double subtotal = n * hourRate; // Subtotal berdasarkan durasi
  double platformFee = subtotal * 0.1; // 10% dari subtotal
  double grandTotal = subtotal + platformFee; // Grand total = subtotal + platform fee

  // Update booking detail
  _bookingDetail.update((detail) {
    if (detail != null) {
      detail.hiringDuration = n;
      detail.subtotal = subtotal;
      detail.platformFee = platformFee;
      detail.grandTotal = grandTotal;
    }
  });
}


  final _bookingDetail = BookingModel(
    userId: '',
    workerId: '',
    date: DateTime.now(),
    hiringDuration: 0,
    subtotal: 0,
    insurance: 599,
    tax: 934,
    platformFee: 0,
    grandTotal: 0,
    payWith: '',
    status: 'In Progress',
    $id: '',
    $createdAt: '',
    $updatedAt: '',
  ).obs;
  BookingModel get bookingDetail => _bookingDetail.value;

  iniBookingDetail(String userId, WorkerModel worker) {
    // Hitung platform fee dan grand total secara dinamis
    double subtotal = duration * worker.hourRate;
    double platformFee = subtotal * 0.1; // 10% dari subtotal
  double grandTotal = subtotal + platformFee; // Grand total = subtotal + platform fee

    _bookingDetail.value = BookingModel(
      userId: userId,
      workerId: worker.$id,
      date: DateTime.now(),
      hiringDuration: duration,
      subtotal: subtotal,
      insurance: 599,
      tax: 934,
      platformFee: platformFee,
      grandTotal: grandTotal,
      payWith: 'Wallet',
      status: 'In Progress',
      $id: '',
      $createdAt: '',
      $updatedAt: '',
      worker: worker,
    );
  }
}
