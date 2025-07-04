import 'package:aluga_facil/app/data/models/inquilino_model.dart';
import 'package:aluga_facil/app/data/repositories/inquilino_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/showmessage.dart';

class CreateInquilinoPageController extends GetxController {
  TextEditingController inputNome = TextEditingController();
  TextEditingController inputCelular = TextEditingController();
  TextEditingController inputTelefone = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputCpf = TextEditingController();
  TextEditingController inputDataNascimento = TextEditingController();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;
  
  final InquilinoRepository inquilinoRepository;

  String dataNascimento = '';

  CreateInquilinoPageController(this.inquilinoRepository);

  saveInquilino() async {
    if (inputNome.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'O nome do inquilino é obrigatório!');
      return;
    } else if (inputCelular.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'O celular do inquilino é obrigatório!');
      return;
    } else if (inputCpf.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'O cpf do inquilino é obrigatório!');
      return;
    }
    isLoading = true;
    InquilinoModel inquilino = InquilinoModel(
      nome: inputNome.text,
      cpf: inputCpf.text,
      celular: inputCelular.text,
      telefone: inputTelefone.text,
      email: inputEmail.text,
      dataNascimento: dataNascimento.isNotEmpty
          ? DateTime.parse(dataNascimento)
          : null,
    );

    await inquilinoRepository.save(inquilino);

    showMessageBar('Sucesso!', 'Novo inquilino cadastrado com sucesso!');
    isLoading = false;

    inquilinoRepository.read();
    Get.toNamed('/home');
  }
}


