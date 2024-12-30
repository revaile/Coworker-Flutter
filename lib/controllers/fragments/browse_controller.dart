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

  List highRatedWorkers = [
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

  List newcomers = [
    {
      'image': 'assets/jundi.png',
      'name': 'Jundi',
      'job': 'Gardener',
    },
    {
      'image': 'assets/mona.png',
      'name': 'Mona',
      'job': 'Chef',
    },
    {
      'image': 'assets/sushi.png',
      'name': 'Sushi',
      'job': 'Tutor',
    },
    {
      'image': 'assets/romi.png',
      'name': 'Romi',
      'job': 'Writer',
    },
    {
      'image': 'assets/lona.png',
      'name': 'Lona',
      'job': 'Cleaner',
    },
    {
      'image': 'assets/daren.png',
      'name': 'Daren',
      'job': 'Security',
    },
  ];

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

  var searchResults = [].obs;

  void search(String query) {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    query = query.toLowerCase();

    // Cari di highRatedWorkers
    var highRatedResults = highRatedWorkers.where((worker) {
      var name = worker['name']?.toString().toLowerCase() ?? '';
      return name.contains(query);
    }).toList();

    // Cari di newcomers
    var newcomersResults = newcomers.where((newcomer) {
      var name = newcomer['name']?.toString().toLowerCase() ?? '';
      var job = newcomer['job']?.toString().toLowerCase() ?? '';
      return name.contains(query) || job.contains(query);
    }).toList();

    // Tentukan hasil akhir
    if (highRatedResults.isNotEmpty) {
      searchResults.assignAll(highRatedResults);
    } else if (newcomersResults.isNotEmpty) {
      searchResults.assignAll(newcomersResults);
    } else {
      // Tidak ada hasil, tambahkan pesan "Not Found"
      searchResults.assignAll([
        {
          'message': 'Not Found',
          'description': 'No matches found for your query'
        }
      ]);
    }
  }
}
