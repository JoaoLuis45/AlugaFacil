import 'package:aluga_facil/app/services/flutter_fire_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPageController extends GetxController {
  final inputEmail = TextEditingController();
  final inputPassword = TextEditingController();
  final inputConfirmPassword = TextEditingController();
  final inputName = TextEditingController();

  final _isLoading = false.obs;
  get isLoading => _isLoading.value;

  onSubmit(BuildContext context) async {
    if (inputName.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('O campo nome é obrigatório!')));
      return;
    } else if (inputEmail.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('O campo email é obrigatório!')));
      return;
    } else if (inputPassword.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('O campo senha é obrigatório!')));
      return;
    } else if (inputPassword.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('O campo confirmação de senha é obrigatório!')),
      );
      return;
    } else if (inputPassword.text.trim() != inputConfirmPassword.text.trim()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('As senhas não conferem!')));
      return;
    }

    try {
      final name = inputName.text;
      final email = inputEmail.text;
      final password = inputPassword.text;

      _isLoading.value = true;

      final result = await FlutterFireAuth(
        context,
      ).createUserWithEmailAndPassword(name, email, password);

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
