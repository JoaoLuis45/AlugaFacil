import 'package:aluga_facil/app/services/flutter_fire_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  final inputEmail = TextEditingController();
  final inputPassword = TextEditingController();

  final _isLoading = false.obs;
  get isLoading => _isLoading.value;

  onSubmit(BuildContext context) async {
    if (inputEmail.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('O campo email é obrigatório!')));
      return;
    } else if (inputPassword.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('O campo senha é obrigatório!')));
      return;
    } 

    try {
      final email = inputEmail.text;
      final password = inputPassword.text;

      _isLoading.value = true;

      final result = await FlutterFireAuth(
        context,
      ).signInWithEmailAndPassword(email, password);

      final user = result['user'];
      final credential = result['credential'];

      _isLoading.value = false;

      if (user != null) {
        Get.offAllNamed(
          'home',
          arguments: {'user': user, 'credential': credential},
        );
      }
    } catch (e) {
      _isLoading.value = false;
    }
  }
}
