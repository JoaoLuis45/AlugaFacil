import 'package:aluga_facil/app/data/models/payment_model.dart';
import 'package:aluga_facil/app/data/repositories/payment_repository.dart';
import 'package:aluga_facil/app/utils/showmessage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CreatePaymentPageController extends GetxController{
  TextEditingController inputCasaId = TextEditingController();
  TextEditingController inputInquilino = TextEditingController();
  TextEditingController inputFormaPagamento = TextEditingController();
  TextEditingController inputValor = TextEditingController();
  TextEditingController inputDataPagamento = TextEditingController();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;
  
  final PaymentRepository paymentRepository;

  String dataPagamento = '';

  CreatePaymentPageController(this.paymentRepository);

  savePayment() async {
    if (inputCasaId.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'A casa do pagamento é obrigatória!');
      return;
    } else if (inputInquilino.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'O inquilino do pagamento é obrigatório!');
      return;
    } else if (inputFormaPagamento.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'A forma do pagamento é obrigatória!');
      return;
    }else if (inputValor.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'O valor do pagamento é obrigatório!');
      return;
    } else if (inputDataPagamento.text.trim().isEmpty) {
      showMessageBar('Aviso!', 'A data do pagamento é obrigatória!');
      return;
    }
    isLoading = true;
    PaymentModel payment = PaymentModel(
      casaId: inputCasaId.text,
      inquilino: inputInquilino.text,
      formaPagamento: inputFormaPagamento.text,
      valor: double.tryParse(inputValor.text) ?? 0.0,
      dataPagamento: dataPagamento.isNotEmpty
          ? DateTime.parse(dataPagamento)
          : null,
    );

    await paymentRepository.save(payment);

    showMessageBar('Sucesso!', 'Novo pagamento realizado com sucesso!');
    isLoading = false;

    paymentRepository.read();
    Get.toNamed('/home');
  }
}