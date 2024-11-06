
import 'package:cowok/config/app_info.dart';
import 'package:cowok/config/enum.dart';
import 'package:cowok/config/session.dart';
import 'package:cowok/datasources/user_datasources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  clear() {
    Get.delete<SignInController>(force: true);
  }

  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool n) => _loading.value = n;

  execute(BuildContext context) {
    if (edtEmail.text == '') {
      AppInfo.failed(context, 'Email wajib diisi');
      return;
    }

    if (!GetUtils.isEmail(edtEmail.text)) {
      AppInfo.failed(context, 'Email tidak valid');
      return;
    }
    

    if (edtPassword.text == '') {
      AppInfo.failed(context, 'Password wajib diisi');
      return;
    }

    if (edtPassword.text.length < 8) {
      AppInfo.failed(context, 'Password minimal 8 karakter');
      return;
    }

    
    loading = true;
    UserDatasource.signIn(
      edtEmail.text,
      edtPassword.text,
    ).then((value) {
      loading = false;
      value.fold(
        (message) {
          AppInfo.failed(context, message);
        },
        (data) {
          // navigator ke dashboard
          // AppSession.setUser(data);
          AppSession.setUser(Map<String, dynamic>.from(data));
          AppInfo.toastSucces('Berhasil');
          Navigator.pushReplacementNamed(context, AppRoute.dashboard.name);
        },
      );
    });
  }
}