import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:aluga_facil/app/data/repositories/house_repository.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CreateHousePageController extends GetxController {
  TextEditingController inputNumeroCasa = TextEditingController();
  TextEditingController inputLogradouro = TextEditingController();
  TextEditingController inputvalorAluguel = TextEditingController();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final HouseRepository houseRepository;

  CreateHousePageController(this.houseRepository);
  // String? fotoCasa;
  // int? id;
  // DateTime? dataAluguel;
  // String? inquilino;

  saveHouse() async{
  if (inputNumeroCasa.text.trim().isEmpty) {
        showMessageBar('Aviso!', 'O número da casa é obrigatório!');
        return;
      } else if (inputLogradouro.text.trim().isEmpty) {
        showMessageBar('Aviso!', 'O logradouro da casa é obrigatório!');
        return;
      } else if (inputvalorAluguel.text.trim().isEmpty) {
        showMessageBar('Aviso!', 'O valor do aluguel da casa é obrigatório!');
        return;
      } 

    isLoading = true;
    HouseModel casa = HouseModel(
      numeroCasa: inputNumeroCasa.text,
      logradouro: inputLogradouro.text,
      valorAluguel: double.tryParse(inputvalorAluguel.text) ?? 0.0,
    );

    await houseRepository.save(casa);

    showMessageBar('Sucesso!', 'Novo imóvel cadastrado com sucesso!');
    isLoading = false;

    houseRepository.readCasas();
    Get.toNamed('/home');
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

