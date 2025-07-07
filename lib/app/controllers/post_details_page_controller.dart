import 'package:aluga_facil/app/data/models/post_model.dart';
import 'package:aluga_facil/app/data/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetailsPageController extends GetxController{
  final post = PostModel().obs;

  TextEditingController inputNumeroCasa = TextEditingController();
  TextEditingController inputLogradouro = TextEditingController();
  TextEditingController inputBairro = TextEditingController();
  TextEditingController inputCidade = TextEditingController();
  TextEditingController inputvalorAluguel = TextEditingController();
  TextEditingController inputDataAluguel = TextEditingController();

  final PostRepository inquilinoRepository = PostRepository(
    PostProvider(),
  );

  final HouseRepository houseRepository = HouseRepository(HouseProvider());
  final PaymentRepository paymentRepository = PaymentRepository(
    PaymentProvider(),
  );

  final inquilino = InquilinoModel().obs;

  final isLoadingInquilino = false.obs;

  late List<dynamic> listaInquilinosDisponiveis;

  final listPayments = [].obs;

  @override
  void onInit() async {
    super.onInit();
    casa.value = Get.arguments;
    getDetailsHouse();
    await getInquilino();
    await getPayments();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<HouseDetailsPageController>();
  }

  getInquilino() async {
    if (casa.value.inquilino != null) {
      isLoadingInquilino.value = true;
      inquilino.value =
          await inquilinoRepository.getInquilino(casa.value.inquilino) ??
          InquilinoModel();
      isLoadingInquilino.value = false;
    }
  }

  getDetailsHouse() {
    inputNumeroCasa.text = casa.value.numeroCasa ?? '';
    inputLogradouro.text = casa.value.logradouro ?? '';
    inputBairro.text = casa.value.bairro ?? '';
    inputCidade.text = casa.value.cidade ?? '';
    inputvalorAluguel.text = casa.value.valorAluguel?.toString() ?? '';
    if (casa.value.dataAluguel != null) {
      inputDataAluguel.text =
          '${casa.value.dataAluguel!.day.toString()} de todo mês';
    } else {
      inputDataAluguel.text = '';
    }
    casa.update((a){});
  }

  getPayments() async {
    listPayments.value =
        await paymentRepository.getPaymentsByHouseAndInquilino(
          casa.value,
          inquilino.value,
        ) ??
        [];
  }

 
}