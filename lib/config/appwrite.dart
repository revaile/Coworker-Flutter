import 'package:appwrite/appwrite.dart';  

class Appwrite {
  static const projectId = '67288a07001efed620f8';
  static const endpoint = 'https://cloud.appwrite.io/v1';

  static const databaseId = '672912e30031a00a44e6';
  static const collectionUsers = '672913ac0005f693ff76';
  static const collectionWorkers = '6729140a0019e2f080ce';
  static const collectionBooking = '67291438001efee95ccd';
  static const bucketWorker = '672920db003c7ba634c0';

  static final Client client = Client();
  static late Account account;
  static late Databases databases;

  static void init() {
    // Initialize the client
    client
        .setProject(projectId)
        .setEndpoint(endpoint);

    // Initialize Account and Databases services
    account = Account(client);
    databases = Databases(client);
  }
}
