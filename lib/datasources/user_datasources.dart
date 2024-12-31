import 'package:appwrite/appwrite.dart';
import 'package:cowok/config/app_log.dart';
import 'package:cowok/config/appwrite.dart';
import 'package:dartz/dartz.dart';

class UserDatasource {
  static Future<Either<String, Map>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      final resultAuth = await Appwrite.account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );

      final response = await Appwrite.databases.createDocument(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionUsers,
        documentId: resultAuth.$id,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      Map data = response.data;
      AppLog.success(
        body: data.toString(),
        title: 'User - SignUp',
      );

      return Right(data);
    } catch (e) {
      AppLog.error(
        body: e.toString(),
        title: 'User - SignUp',
      );

      String defaultMessage = 'Terjadi suatu masalah';
      String message = defaultMessage;

      if (e is AppwriteException) {
        if (e.code == 409) {
          message = 'Email sudah terdaftar';
        } else {
          message = e.message ?? defaultMessage;
        }
      }

      return Left(message);
    }
  }

  static Future<Either<String, Map>> signIn(
    String email,
    String password,
  ) async {
    try {
      // Cek apakah pengguna sudah memiliki sesi yang aktif
      try {
        // Jika pengguna sudah terautentikasi, hapus sesi aktif
        await Appwrite.account.deleteSession(sessionId: 'current');
        // Hapus sesi 'current' untuk memastikan pengguna harus login kembali
      } catch (e) {
        // Jika tidak ada sesi aktif, lanjutkan ke proses login
        if (e is! AppwriteException || e.code != 401) {
          return const Left('Error checking user session: ');
        }
      }

      // Coba buat sesi baru dengan kredensial yang diberikan
      final resultAuth = await Appwrite.account.createEmailPasswordSession(
        email: email,
        password: password,
      );

      // Jika pembuatan sesi berhasil, userId tidak boleh null atau kosong
      if (resultAuth.userId.isEmpty) {
        return const Left('Login failed: Invalid credentials provided');
      }

      // Ambil data pengguna dari database berdasarkan userId
      final response = await Appwrite.databases.getDocument(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionUsers,
        documentId: resultAuth.userId,
      );

      Map<String, dynamic> data = Map<String, dynamic>.from(response.data);

      AppLog.success(
        body: data.toString(),
        title: 'User - SignIn',
      );

      return Right(data);
    } catch (e) {
      // Tangani kesalahan yang terjadi selama proses login
      AppLog.error(
        body: e.toString(),
        title: 'User - SignIn',
      );

      String defaultMessage = 'Terjadi suatu masalah';
      String message = defaultMessage;

      if (e is AppwriteException) {
        if (e.code == 401) {
          message = 'Email atau password salah';
        } else {
          message = e.message ?? defaultMessage;
        }
      }

      return Left(message);
    }
  }
}
