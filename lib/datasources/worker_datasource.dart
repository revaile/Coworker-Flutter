import 'package:appwrite/appwrite.dart';
import 'package:cowok/config/app_log.dart';
import 'package:cowok/config/appwrite.dart';
import 'package:cowok/models/worker_model.dart';
import 'package:dartz/dartz.dart';

class WorkerDatasource {
  static Future<Either<String, List<WorkerModel>>> fetchAvailable(
    String category,
  ) async {
    try {
      final response = await Appwrite.databases.listDocuments(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionWorkers,
        queries: [
          Query.equal('category', category),
          Query.equal('status', 'Available'),
        ],
      );

      if (response.total < 1) {
        AppLog.error(
          body: 'Not Found',
          title: 'Worker - fetchAvailable',
        );

        return const Left('Tidak ditemukan');
      }

      AppLog.success(
        body: response.toMap().toString(),
        title: 'Worker - fetchAvailable',
      );

      List<WorkerModel> workers = response.documents.map((e) {
        return WorkerModel.fromJson(e.data);
      }).toList();

      return Right(workers);
    } catch (e) {
      AppLog.error(
        body: e.toString(),
        title: 'Worker - fetchAvailable',
      );

      String defaulMessage = 'Terjadi suatu masalah';
      String message = defaulMessage;

      if (e is AppwriteException) {
        message = e.message ?? defaulMessage;
      }

      return Left(message);
    }
  }
  static Future<Either<String, List<WorkerModel>>> fetchTopRated() async {
    try {
      // Query for workers with rating above 4.5
      final response = await Appwrite.databases.listDocuments(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionWorkers,
        queries: [
          Query.greaterThanEqual('rating', 4.5), // Rating filter
        ],
      );

      if (response.total < 1) {
        AppLog.error(
          body: 'No top-rated workers found',
          title: 'Worker - fetchTopRated',
        );

        return const Left('No top-rated workers found');
      }

      AppLog.success(
        body: response.toMap().toString(),
        title: 'Worker - fetchTopRated',
      );

      List<WorkerModel> workers = response.documents.map((e) {
        return WorkerModel.fromJson(e.data);
      }).toList();

      return Right(workers);
    } catch (e) {
      AppLog.error(
        body: e.toString(),
        title: 'Worker - fetchTopRated',
      );

      String defaulMessage = 'An error occurred';
      String message = defaulMessage;

      if (e is AppwriteException) {
        message = e.message ?? defaulMessage;
      }

      return Left(message);
    }
  }
  // total
  static Future<Either<String, Map<String, int>>> fetchStats(
  ) async {
    try {
      // Ambil total worker
      final totalResponse = await Appwrite.databases.listDocuments(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionWorkers,
      );

      // Ambil available worker
      final availableResponse = await Appwrite.databases.listDocuments(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionWorkers,
        queries: [
          Query.equal('status', 'Available'),
        ],
      );

      AppLog.success(
        body: {
          'total': totalResponse.total,
          'available': availableResponse.total,
        }.toString(),
        title: 'Worker - fetchStats',
      );

      return Right({
        'total': totalResponse.total,
        'available': availableResponse.total,
      });
    } catch (e) {
      AppLog.error(
        body: e.toString(),
        title: 'Worker - fetchStats',
      );

      String defaulMessage = 'Terjadi suatu masalah';
      String message = defaulMessage;

      if (e is AppwriteException) {
        message = e.message ?? defaulMessage;
      }

      return Left(message);
    }
  }
  
  // Fetch newcomers
  static Future<Either<String, List<WorkerModel>>> fetchNewcomers() async {
    try {
      // Get the current date-time and calculate 7 days ago
      final now = DateTime.now();
      final oneWeekAgo = now.subtract(const Duration(days: 7)).toIso8601String();

      // Query workers added after oneWeekAgo
      final response = await Appwrite.databases.listDocuments(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionWorkers,
        queries: [
          Query.greaterThanEqual('\$createdAt', oneWeekAgo),
        ],
      );

      if (response.total < 1) {
        AppLog.error(
          body: 'No newcomers found',
          title: 'Worker - fetchNewcomers',
        );
        return const Left('No newcomers found');
      }

      AppLog.success(
        body: response.toMap().toString(),
        title: 'Worker - fetchNewcomers',
      );

      List<WorkerModel> workers = response.documents.map((e) {
        return WorkerModel.fromJson(e.data);
      }).toList();

      return Right(workers);
    } catch (e) {
      AppLog.error(
        body: e.toString(),
        title: 'Worker - fetchNewcomers',
      );

      String defaulMessage = 'An error occurred';
      String message = defaulMessage;

      if (e is AppwriteException) {
        message = e.message ?? defaulMessage;
      }

      return Left(message);
    }
  }
}
