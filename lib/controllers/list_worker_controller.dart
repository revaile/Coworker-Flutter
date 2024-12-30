import 'package:cowok/datasources/worker_datasource.dart';
import 'package:cowok/models/worker_model.dart';
import 'package:get/get.dart';

class ListWorkerController extends GetxController {
  // Menghapus controller dari memory
  clear() {
    Get.delete<ListWorkerController>(force: true);
  }

  // Data pekerja dengan rating tinggi
  final topRated = [
    {
      'image': 'assets/shian.png',
      'name': 'Shian',
      'rate': 4.8,
    },
    {
      'image': 'assets/cindinan.png',
      'name': 'Cindinan',
      'rate': 4.9,
    },
    {
      'image': 'assets/ajinomo.png',
      'name': 'Ajinomo',
      'rate': 4.8,
    },
    {
      'image': 'assets/sajima.png',
      'name': 'Sajima',
      'rate': 4.8,
    },
  ];

  // Daftar pekerja yang tersedia
  final _availableWorkers = <WorkerModel>[].obs;
  List<WorkerModel> get availableWorkers => _availableWorkers;
  set availableWorkers(List<WorkerModel> n) => _availableWorkers.value = n;

  // Daftar pekerja yang difilter berdasarkan pencarian
  final _filteredWorkers = <WorkerModel>[].obs;
  List<WorkerModel> get filteredWorkers => _filteredWorkers;
  set filteredWorkers(List<WorkerModel> n) => _filteredWorkers.value = n;

  // Status pengambilan data
  final _statusFetch = ''.obs;
  String get statusFetch => _statusFetch.value;
  set statusFetch(String n) => _statusFetch.value = n;

  // Fungsi untuk mengambil data pekerja berdasarkan kategori
  fetchAvailable(String category) {
    statusFetch = 'Loading';
    WorkerDatasource.fetchAvailable(category).then((value) {
      value.fold(
        (message) {
          statusFetch = message;
        },
        (workers) {
          statusFetch = 'Success';
          availableWorkers = workers;
          filteredWorkers = workers; // Inisialisasi daftar yang difilter
        },
      );
    });
  }

  // Fungsi untuk melakukan pencarian pekerja berdasarkan nama
  searchWorker(String query) {
    if (query.isEmpty) {
      // Jika pencarian kosong, tampilkan semua pekerja
      filteredWorkers = availableWorkers;
    } else {
      // Filter pekerja berdasarkan nama yang mengandung teks pencarian
      filteredWorkers = availableWorkers
          .where((worker) => worker.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
