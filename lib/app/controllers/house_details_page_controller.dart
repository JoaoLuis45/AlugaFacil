import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HouseDetailsPageController extends GetxController {
  final casa = HouseModel().obs;

  TextEditingController inputNumeroCasa = TextEditingController();
  TextEditingController inputLogradouro = TextEditingController();
  TextEditingController inputBairro = TextEditingController();
  TextEditingController inputCidade = TextEditingController();
  TextEditingController inputvalorAluguel = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    casa.value = Get.arguments;
    getDetailsHouse();
  }

  getDetailsHouse() {
    inputNumeroCasa.text = casa.value.numeroCasa ?? '';
    inputLogradouro.text = casa.value.logradouro ?? '';
    inputBairro.text = casa.value.bairro ?? '';
    inputCidade.text = casa.value.cidade ?? '';
    inputvalorAluguel.text = casa.value.valorAluguel?.toString() ?? '';
  }
}
