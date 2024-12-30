import 'package:cowok/datasources/worker_datasource.dart';
import 'package:cowok/models/worker_model.dart';
import 'package:get/get.dart';

class BrowseController extends GetxController {
  clear() {
    Get.delete<BrowseController>(force: true);
  }

  List categories = [
    {
      'label': 'Driver',
      'icon': 'assets/ic_driver.png',
    },
    {
      'label': 'Tutor',
      'icon': 'assets/ic_tutor.png',
    },
    {
      'label': 'Gardener',
      'icon': 'assets/ic_gardener.png',
    },
    {
      'label': 'Cleaner',
      'icon': 'assets/ic_cleaner.png',
    },
    {
      'label': 'Other',
      'icon': 'assets/ic_others.png',
    },
  ];

  // Data pekerja dengan rating tinggi
  final _topRated = <WorkerModel>[].obs;
  List<WorkerModel> get topRated => _topRated;
  set topRated(List<WorkerModel> workers) => _topRated.value = workers;
  
  // Status for fetching top-rated workers
  final _statusTopRated = ''.obs;
  String get statusTopRated => _statusTopRated.value;
  set statusTopRated(String status) => _statusTopRated.value = status;

  // Data pekerja baru
  final _newcomers = <WorkerModel>[].obs;
  List<WorkerModel> get newcomers => _newcomers;
  set newComers(List<WorkerModel> workers) => _newcomers.value = workers;

  // Daftar pekerja yang difilter berdasarkan pencarian
  final _filteredWorkers = <WorkerModel>[].obs;
  List<WorkerModel> get filteredWorkers => _filteredWorkers;
  set filteredWorkers(List<WorkerModel> n) => _filteredWorkers.value = n;

  List curatedTips = [
    {
      'image': 'assets/news1.png',
      'name': '12 Tips Seleksi Pekerja',
      'category': 'Productivity',
      'is_popular': false,
      'url': 'https://www.google.com/search?q=12+Tips+Seleksi+Pekerja',
      'route': '/tipsSelection',
    },
    {
      'image': 'assets/news3.png',
      'name': 'Kapan Harus Scale Up?',
      'category': 'Business',
      'is_popular': true,
      'url': 'https://www.google.com/search?q=Kapan+Harus+Scale+Up',
      'route': '/scaleUpTips',
    },
    {
      'image': 'assets/news2.png',
      'name': 'Pemilihan Alat Cleaner',
      'category': 'Health',
      'is_popular': false,
      'url': 'https://www.google.com/search?q=Pemilihan+Alat+Cleaner',
      'route': '/cleanerSelection',
    },
  ];

  // Fungsi untuk melakukan pencarian pekerja berdasarkan nama
  searchWorker(String query) {
    if (query.isEmpty) {
      // Jika pencarian kosong, tampilkan semua pekerja
      filteredWorkers = topRated;
    } else {
      // Filter pekerja berdasarkan nama yang mengandung teks pencarian
      filteredWorkers = topRated
          .where((worker) => worker.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  // Fetch top-rated workers from the database
  Future<void> fetchTopRatedWorkers() async {
    statusTopRated = 'Loading';
    final response = await WorkerDatasource.fetchTopRated();
    response.fold(
      (errorMessage) {
        statusTopRated = errorMessage;
      },
      (workers) {
        statusTopRated = 'Success';
        topRated = workers;
      },
    );
  }

  // Fetch top-rated workers from the database
  Future<void> fetchNewcomerWorkers() async {
    statusTopRated = 'Loading';
    final response = await WorkerDatasource.fetchNewcomers();
    response.fold(
      (errorMessage) {
        statusTopRated = errorMessage;
      },
      (workers) {
        statusTopRated = 'Success';
        topRated = workers;
      },
    );
  }
}
