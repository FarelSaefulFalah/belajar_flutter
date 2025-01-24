import 'package:belajar_flutter/app/modules/dashboard/views/dashboard_view.dart';
import 'package:belajar_flutter/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class LoginController extends GetxController {
  final _getConnect = GetConnect();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authToken = GetStorage();

  void loginNow() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Validasi input
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Get.snackbar(
        'Error',
        'Email harus diisi dan berformat email yang valid.',
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (password.isEmpty || password.length < 8) {
      Get.snackbar(
        'Error',
        'Password harus diisi dan minimal 8 karakter.',
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Kirim data ke server
    final response = await _getConnect.post(BaseUrl.login, {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      authToken.write('token', response.body['token']);
      Get.offAll(() => const DashboardView());
    } else {
      Get.snackbar(
        'Error',
        response.body['error'].toString(),
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}