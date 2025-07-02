import 'package:aluga_facil/app/controllers/user_controller.dart';
import 'package:aluga_facil/app/data/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPageController extends GetxController {
  final inputEmail = TextEditingController();
  final inputPassword = TextEditingController();
  final inputConfirmPassword = TextEditingController();
  final inputName = TextEditingController();

  final UserRepository _repository;

  SignupPageController(this._repository);

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

      final user = await _repository.signUp(email, password, name);

      _isLoading.value = false;

      Get.put<UserController>(UserController());
      if (user != null) {
        Get.offAllNamed('/home');
      }
    } on FirebaseAuthException catch (e) {
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
