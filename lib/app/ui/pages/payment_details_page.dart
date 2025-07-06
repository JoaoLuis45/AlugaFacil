import 'package:aluga_facil/app/controllers/payment_details_page_controller.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/ui/widgets/visualize_form_field.dart';
import 'package:aluga_facil/app/utils/show_dialog_message.dart';
import 'package:aluga_facil/app/utils/showmessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentDetailsPage extends GetView<PaymentDetailsPageController> {
  const PaymentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: goldColorThree),
        centerTitle: true,
        title: Text(
          'Detalhes do Pagamento',
          style: TextStyle(color: goldColorThree),
        ),
        backgroundColor: brownColorOne,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(
                '/createPayment',
                arguments: controller.payment.value,
              );
            },
            icon: Icon(Icons.edit_square, color: goldColorThree),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Spacer(flex: 3),
                Center(
                  child: Hero(
                    tag: controller.payment.value,
                    child: CircleAvatar(
                      radius: 82,
                      backgroundColor: goldColorTwo,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: brownColorTwo,
                        child: Icon(
                          Icons.attach_money_outlined,
                          color: goldColorThree,
                          size: 100,
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 3),
                VisualizeTextFormField(
                  textController: controller.inputValor,
                  keyy: 'valor',
                  iconImage: Icons.attach_money_outlined,
                  title: 'Valor',
                ),
                Spacer(flex: 2),
                VisualizeTextFormField(
                  textController: controller.inputFormaPagamento,
                  keyy: 'FormaPagamento',
                  iconImage: Icons.monetization_on_outlined,
                  title: 'Forma de Pagamento',
                ),
                Spacer(flex: 2),
                VisualizeTextFormField(
                  textController: controller.inputDataPagamento,
                  keyy: 'dataPagamento',
                  iconImage: Icons.today_outlined,
                  title: 'Data de Pagamento',
                ),
                Spacer(flex: 2),
                Obx(() {
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Casa Vinculada',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: brownColorTwo,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 8,
                        color: brownColorOne,
                        child: ListTile(
                          leading: Icon(Icons.person, color: goldColorThree),
                          title: Text(
                            controller.casa.value.numeroCasa ?? '',
                            style: TextStyle(
                              color: goldColorThree,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            controller.casa.value.logradouro ?? '',
                            style: TextStyle(color: goldColorTwo, fontSize: 16),
                          ),
                          onTap: () {
                            Get.toNamed(
                              '/detailsHouse',
                              arguments: controller.casa.value,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
                Spacer(flex: 2),
                Obx(() {
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Inquilino Vinculado',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: brownColorTwo,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 8,
                        color: brownColorOne,
                        child: ListTile(
                          leading: Icon(Icons.person, color: goldColorThree),
                          title: Text(
                            controller.inquilino.value.nome ?? '',
                            style: TextStyle(
                              color: goldColorThree,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            controller.inquilino.value.cpf ?? '',
                            style: TextStyle(color: goldColorTwo, fontSize: 16),
                          ),
                          onTap: () {
                            Get.toNamed(
                              '/detailsInquilino',
                              arguments: controller.inquilino.value,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),             
                Spacer(flex: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
