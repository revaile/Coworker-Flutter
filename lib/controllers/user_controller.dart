import 'package:get/get.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  final _data = UserModel().obs;
  UserModel get data => _data.value;
  set data(UserModel n) => _data.value = n;
}
