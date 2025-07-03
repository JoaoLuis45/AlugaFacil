import 'dart:io';

import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:aluga_facil/app/data/repositories/house_repository.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CreateHousePageController extends GetxController {
  TextEditingController inputNumeroCasa = TextEditingController();
  TextEditingController inputLogradouro = TextEditingController();
  TextEditingController inputBairro = TextEditingController();
  TextEditingController inputCidade = TextEditingController();
  TextEditingController inputvalorAluguel = TextEditingController();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final HouseRepository houseRepository;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  final fotoCasa = ''.obs;
  final isLoadingfotoCasa = false.obs;

  CreateHousePageController(this.houseRepository);
  // DateTime? dataAluguel;
  // String? inquilino;

  saveHouse() async {
    if (inputNumeroCasa.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'O número da casa é obrigatório!');
      return;
    } else if (inputLogradouro.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'O logradouro da casa é obrigatório!');
      return;
    } else if (inputvalorAluguel.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'O valor do aluguel da casa é obrigatório!');
      return;
    } else if (inputBairro.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'O bairro da casa é obrigatório!');
      return;
    } else if (inputvalorAluguel.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'A cidade da casa é obrigatória!');
      return;
    }

    isLoading = true;
    HouseModel casa = HouseModel(
      numeroCasa: inputNumeroCasa.text,
      logradouro: inputLogradouro.text,
      bairro: inputBairro.text,
      cidade: inputCidade.text,
      fotoCasa: fotoCasa.value,
      valorAluguel: double.tryParse(inputvalorAluguel.text) ?? 0.0,
    );

    await houseRepository.save(casa);

    showMessageBar('Sucesso!', 'Novo imóvel cadastrado com sucesso!');
    isLoading = false;

    houseRepository.readCasas();
    Get.toNamed('/home');
  }

  _uploadImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      return File(result.files.first.path!);
    }
  }

  Future<String?> switchHousePhoto() async {
    try {
      isLoadingfotoCasa.value = true;
      final avatar = await _uploadImage();

      if (avatar != null) {
        final fileName = '${const Uuid().v4()}.${avatar.path.split('.').last}';

        final fileRef = _storage.ref(fileName);

        await fileRef.putFile(avatar);

        final fileUrl = await fileRef.getDownloadURL();

        fotoCasa.value = fileUrl;
        isLoadingfotoCasa.value = false;
      }
      isLoadingfotoCasa.value = false;
      return '';
    } catch (e) {
      showMessageBar('Erro!', e.toString());
      return Future.error(Exception('Erro ao fazer upload da imagem: $e'));
    }
  }
}

showMessageBar(title, subtitle) {
  Get.snackbar(
    title,
    subtitle,
    backgroundColor: brownColorTwo,
    colorText: goldColorThree,
    duration: const Duration(seconds: 6),
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(10),
  );
}
