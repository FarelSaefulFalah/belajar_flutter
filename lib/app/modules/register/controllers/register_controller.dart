import 'package:belajar_flutter/app/modules/dashboard/views/dashboard_view.dart';
import 'package:belajar_flutter/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegisterController extends GetxController {
  final _getConnect = GetConnect();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  final authToken = GetStorage();

  void registerNow() async {
    // Validasi inputan
    if (nameController.text.isEmpty) {
      _showErrorSnackbar('Error', 'Nama Tidak Boleh Kosong');
      return;
    }
    if (emailController.text.isEmpty || !GetUtils.isEmail(emailController.text)) {
      _showErrorSnackbar('Error', 'Wajib berformat email & tidak boleh kosong');
      return;
    }
    if (passwordController.text.isEmpty || passwordController.text.length < 8) {
      _showErrorSnackbar('Error', 'Tidak boleh kosong & minimal 8 character');
      return;
    }
    if (passwordController.text != passwordConfirmationController.text) {
      _showErrorSnackbar('Error', 'Konfirmasi Password tidak sama');
      return;
    }

    // Jika validasi lolos, lakukan register
    final response = await _getConnect.post(BaseUrl.register, {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'password_confirmation': passwordConfirmationController.text,
    });

    if (response.statusCode == 201) {
      authToken.write('token', response.body['token']);
      Get.offAll(() => const DashboardView());
    } else {
      _showErrorSnackbar('Error', response.body['error'].toString());
    }
  }

  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      icon: const Icon(Icons.error),
      backgroundColor: Colors.red,
      colorText: Colors.white,
      forwardAnimationCurve: Curves.bounceIn,
      margin: const EdgeInsets.only(
        top: 10,
        left: 5,
        right: 5,
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    passwordConfirmationController.dispose();
    super.onClose();
  }
}
