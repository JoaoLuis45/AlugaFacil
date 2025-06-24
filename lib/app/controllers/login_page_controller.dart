import 'package:aluga_facil/app/data/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  final inputEmail = TextEditingController();
  final inputPassword = TextEditingController();

  final UserRepository _repository;

  LoginPageController(this._repository);

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

      final user = await _repository.login(email, password);

      _isLoading.value = false;

      if (user != null) {
        Get.offAllNamed('/home',);
      }
    }on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Ocorreu um erro desconhecido!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally{
      _isLoading.value = false;
    }
  }
}
