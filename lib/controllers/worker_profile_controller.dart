import 'package:cowok/datasources/booking_datasource.dart';
import 'package:get/get.dart';

class WorkerProfileController extends GetxController {
  // Membuat recruiterId sebagai variabel reaktif
  var _recruiterId = ''.obs;
  String get recruiterId => _recruiterId.value;
  set recruiterId(String n) => _recruiterId.value = n;

  // Fungsi untuk memeriksa status pekerjaan oleh recruiter
  Future<void> checkHiredBy(String workerId) async {
    // Menunggu hasil dari checkHireBy
    final result = await BookingDatasource.checkHireBy(workerId);

    // Mengubah recruiterId berdasarkan hasil
    result.fold(
      (message) {
        // Jika worker tersedia, set ke Available
        recruiterId = 'Available';
      },
      (booking) {
        // Jika worker sudah dipekerjakan, set recruiterId dengan userId
        recruiterId = booking.userId;
      },
    );
  }

  // Fungsi untuk membersihkan controller
  void clear() {
    Get.delete<WorkerProfileController>(force: true);
    super.onClose();
  }
}
