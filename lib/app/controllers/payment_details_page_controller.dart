import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:aluga_facil/app/data/models/inquilino_model.dart';
import 'package:aluga_facil/app/data/models/payment_model.dart';
import 'package:aluga_facil/app/data/providers/house_provider.dart';
import 'package:aluga_facil/app/data/providers/inquilino_provider.dart';
import 'package:aluga_facil/app/data/providers/payment_provider.dart';
import 'package:aluga_facil/app/data/repositories/house_repository.dart';
import 'package:aluga_facil/app/data/repositories/inquilino_repository.dart';
import 'package:aluga_facil/app/data/repositories/payment_repository.dart';
import 'package:aluga_facil/app/utils/normal_date.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PaymentDetailsPageController extends GetxController {
  final payment = PaymentModel().obs;

  TextEditingController inputValor = TextEditingController();
  TextEditingController inputFormaPagamento = TextEditingController();
  TextEditingController inputDataPagamento = TextEditingController();

  final PaymentRepository paymentRepository = PaymentRepository(
    PaymentProvider(),
  );

  final HouseRepository houseRepository = HouseRepository(HouseProvider());
  final InquilinoRepository inquilinoRepository = InquilinoRepository(
    InquilinoProvider(),
  );

  final casa = HouseModel().obs;
  final inquilino = InquilinoModel().obs;

  @override
  void onInit() async {
    super.onInit();
    payment.value = Get.arguments;
    await getDetailsPayments();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<PaymentDetailsPageController>();
  }

  getDetailsPayments() async {
    inputValor.text = double.tryParse(payment.value.valor.toString()) == null
        ? ''
        : payment.value.valor.toString();
    inputDataPagamento.text = payment.value.dataPagamento == null
        ? ''
        : formatDate(payment.value.dataPagamento);
    inputFormaPagamento.text = payment.value.formaPagamento ?? '';
    casa.value = (await houseRepository.getCasa(payment.value.casaId!))!;
    inquilino.value = (await inquilinoRepository.getInquilino(
      payment.value.inquilino!,
    ))!;
  }
}
