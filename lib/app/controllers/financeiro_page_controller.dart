import 'package:aluga_facil/app/controllers/user_controller.dart';
import 'package:aluga_facil/app/data/models/payment_model.dart';
import 'package:aluga_facil/app/data/providers/inquilino_provider.dart';
import 'package:aluga_facil/app/data/repositories/inquilino_repository.dart';
import 'package:aluga_facil/app/data/repositories/payment_repository.dart';
import 'package:aluga_facil/app/utils/normal_date.dart';
import 'package:aluga_facil/app/utils/showmessage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:receipt_generator/receipt_generator.dart';

class FinanceiroPageController extends GetxController {
  final lista = [].obs;

  final isLoading = false.obs;
  final isPaymentLoading = false.obs;

  final PaymentRepository paymentRepository;

  InquilinoRepository inquilinoRepository = InquilinoRepository(
    InquilinoProvider(),
  );

  final userController = Get.find<UserController>();

  FinanceiroPageController(this.paymentRepository);

  TextEditingController searchController = TextEditingController();

  Future<void> generateReceipt(PaymentModel payment) async {
    isPaymentLoading.value = true;
    final generator = ReceiptGenerator();
    final data = {
      "number": "",
      "amount": "",
      "transactionid": "",
      "paymentmode": "",
    };
    String logoPath = 'assets/logoAlugaFacilTransparent.png';
    String fontPath = "assets/OpenSans_SemiCondensed-Regular.ttf";

    String thankYouMessage =
        "Pagamento referente ao aluguel do mês de ${payment.dataPagamento!.month - 1} de ${payment.dataPagamento!.year}.";
    String companyName = "AlugaFácil";
    String colorHex = "bf8100";
    final localization = {
      'receiptTitle': 'Recibo de Pagamento',
      'clientContact':
          'Email para contato : ${userController.loggedUser.email ?? ""}',
      'paymentMode': payment.formaPagamento ?? "",
      'amountPaid': 'Total pago : ${payment.valor}',
      'transactionId': 'Identificador da Transação : ${payment.id}',
      'dateTime': 'Data do pagamento : ${formatDate(payment.dataPagamento!)}',
    };

    try {
      final pdfPath = await generator.generateReceipt(
        data,
        logoPath,
        thankYouMessage,
        fontPath,
        companyName,
        colorHex,
        localization,
      );
      showMessageBar('Sucesso', 'Recibo gerado com sucesso!');
      await OpenFile.open(pdfPath);
    } catch (e) {
      showMessageBar('Erro', 'Erro ao gerar recibo: $e');
    } finally {
      isPaymentLoading.value = false;
    }
  }
}
