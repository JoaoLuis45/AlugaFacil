import 'dart:io';
import 'dart:typed_data';

import 'package:aluga_facil/app/controllers/user_controller.dart';
import 'package:aluga_facil/app/data/models/payment_model.dart';
import 'package:aluga_facil/app/data/providers/house_provider.dart';
import 'package:aluga_facil/app/data/providers/inquilino_provider.dart';
import 'package:aluga_facil/app/data/repositories/house_repository.dart';
import 'package:aluga_facil/app/data/repositories/inquilino_repository.dart';
import 'package:aluga_facil/app/data/repositories/payment_repository.dart';
import 'package:aluga_facil/app/utils/normal_date.dart';
import 'package:aluga_facil/app/utils/showmessage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:receipt_generator/receipt_generator.dart';
import 'package:pdf/widgets.dart' as pw;

class FinanceiroPageController extends GetxController {
  final lista = [].obs;

  final isLoading = false.obs;
  final isPaymentLoading = false.obs;

  final PaymentRepository paymentRepository;

  InquilinoRepository inquilinoRepository = InquilinoRepository(
    InquilinoProvider(),
  );

  HouseRepository houseRepository = HouseRepository(
    HouseProvider(),
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

  Future<void> gerarESalvarRecibo(PaymentModel payment) async {
  final doc = pw.Document();

  final inquilino = await inquilinoRepository.getInquilino(payment.inquilino); 
  final house = await houseRepository.getCasa(payment.casaId!);

  // Carregar a logo como Uint8List
  final ByteData logoData = await rootBundle.load('assets/logoAlugaFacilTransparent.png');
  final Uint8List logoBytes = logoData.buffer.asUint8List();
  final imageLogo = pw.MemoryImage(logoBytes);

  doc.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Padding(
        padding: const pw.EdgeInsets.all(24),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(child: pw.Image(imageLogo, width: 120)),
            pw.SizedBox(height: 24),
            pw.Text('RECIBO DE PAGAMENTO', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 16),
            pw.Text('Nome do Inquilino: ${inquilino!.nome}'),
            pw.SizedBox(height: 8),
            pw.Text('Número da Casa: ${house!.numeroCasa}'),
            pw.SizedBox(height: 8),
            pw.Text('Valor do Pagamento: R\$ ${payment.valor}'),
            pw.SizedBox(height: 8),
            pw.Text('Forma de Pagamento: ${payment.formaPagamento}'),
            pw.SizedBox(height: 8),
            pw.Text('Data do Pagamento: ${payment.dataPagamento!.day}/${payment.dataPagamento!.month}/${payment.dataPagamento!.year}'),
            pw.SizedBox(height: 8),
            pw.Text('Pagamento referente ao dia ${payment.dataPagamento!.day} do mês ${payment.dataPagamento!.month - 1 } de ${payment.dataPagamento!.year}.'),
            pw.SizedBox(height: 8),
            pw.Text('Identificador da Transação: ${payment.id}'),
            pw.SizedBox(height: 128),
            pw.Text('Assinatura do Inquilino: ____________________________', style: pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );

  // Salvar localmente
  final outputDir = await getApplicationDocumentsDirectory();
  final file = File('${outputDir.path}/recibo_${DateTime.now().millisecondsSinceEpoch}.pdf');
  await file.writeAsBytes(await doc.save());

  // Mostrar visualizador para opção de imprimir
  await Printing.layoutPdf(onLayout: (format) async => doc.save());

  debugPrint('PDF salvo em: ${file.path}');
}
}
