import 'package:cowok/models/worker_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';



class SearchController extends GetxController {
  var searchText = ''.obs; // For the search text
  var filteredList = <WorkerModel>[].obs; // For search results

  // Original list of workers (this can be loaded from a database, API, etc.)
  var workerList = <WorkerModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // You can load your worker data here, for example:
    // workerList.addAll(fetchDataFromAPI());
  }

  // Method for performing the search
  void search(String query) {
    searchText.value = query;

    if (query.isEmpty) {
      filteredList.value = workerList; // Show all workers if the search is empty
    } else {
      filteredList.value = workerList
          .where((worker) =>
              worker.name.toLowerCase().contains(query.toLowerCase()) ||
              worker.category.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}

