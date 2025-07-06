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
  final isEditing = false.obs;
  final inquilino = InquilinoModel().obs;
  
  final InquilinoRepository inquilinoRepository;

  String dataNascimento = '';

  CreateInquilinoPageController(this.inquilinoRepository);

  @override
  void onInit() {
    super.onInit();
    editInquilino();
  }

  editInquilino(){
    if (Get.arguments != null) {
      inquilino.value = Get.arguments as InquilinoModel;
      inputNome.text = inquilino.value.nome ?? '';
      inputCelular.text = inquilino.value.celular ?? '';
      inputTelefone.text = inquilino.value.telefone ?? '';
      inputEmail.text = inquilino.value.email ?? '';
      inputCpf.text = inquilino.value.cpf ?? '';
      dataNascimento = inquilino.value.dataNascimento?.toString() ?? '';
      isEditing.value = true;
    } else {
      inputNome.clear();
      inputCelular.clear();
      inputTelefone.clear();
      inputEmail.clear();
      inputCpf.clear();
      dataNascimento = '';
      isEditing.value = false;
    }
  }

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
    }else if (inputDataNascimento.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'A data de nascimento do inquilino é obrigatória!');
      return;
    }
    
    isLoading = true;
    
    if (isEditing.value) {
      
        inquilino.value.nome = inputNome.text;
        inquilino.value.celular = inputCelular.text;
        inquilino.value.telefone = inputTelefone.text;
        inquilino.value.email = inputEmail.text;
        inquilino.value.cpf = inputCpf.text;
        inquilino.value.dataNascimento = dataNascimento.isNotEmpty
          ? DateTime.parse(dataNascimento)
          : null;
      await inquilinoRepository.update(inquilino.value);
      showMessageBar('Sucesso!', 'Inquilino editado com sucesso!');
    } else {
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
    }


    isLoading = false;

    inquilinoRepository.read();
    Get.toNamed('/home');
  }
}


