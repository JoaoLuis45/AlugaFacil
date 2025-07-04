import 'package:aluga_facil/app/controllers/financeiro_page_controller.dart';
import 'package:aluga_facil/app/data/models/payment_model.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/utils/normal_date.dart';
import 'package:aluga_facil/app/utils/show_dialog_message.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class FinanceiroPage extends GetView<FinanceiroPageController> {
  const FinanceiroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Meus Pagamentos',
                style: TextStyle(
                  color: brownColorTwo,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimSearchBar(
                  width: Get.width * 0.9,
                  helpText: 'Pesquisar Inquilino...',
                  boxShadow: true,
                  textFieldColor: goldColorThree,
                  searchIconColor: goldColorThree,
                  textFieldIconColor: brownColorTwo,
                  color: brownColorTwo,
                  textController: controller.searchController,
                  suffixIcon: const Icon(Icons.close, color: goldColorThree),
                  onSuffixTap: () {},
                  onSubmitted: (a) {
                    // print('aaaaaaaaaaaaa');
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                color: brownColorOne,
                elevation: 8,
                child: IconButton(
                  onPressed: () {
                    // Get.toNamed('/createInquilino');
                  },
                  icon: Icon(Icons.attach_money_rounded, color: goldColorThree, size: 32),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Obx(() {
            return controller.isLoading.value
                ? CircularProgressIndicator(color: goldColorThree)
                : controller.lista.isEmpty
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.money_off_sharp,
                          size: 100,
                          color: brownColorTwo,
                        ),
                        Text(
                          'Nenhum pagamento realizado',
                          style: TextStyle(
                            color: brownColorTwo,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => controller.paymentRepository.read(),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final PaymentModel payment =
                              controller.lista[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Card(
                              color: goldColorThree,
                              elevation: 8,
                              child: ListTile(
                                leading: Hero(
                                  tag: payment,
                                  child: Icon(
                                    Icons.attach_money_outlined,
                                    color: brownColorTwo,
                                    size: 64,
                                  ),
                                ),
                                title: Text(
                                  '${payment.valor!.toStringAsFixed(2)} >> Forma pagamento: ${payment.formaPagamento ?? 'Não informada'}',
                                ),
                                subtitle: Text(formatDate(payment.dataPagamento)),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: brownColorTwo,
                                  ),
                                  onPressed: () async {
                                    final result = await showDialogMessage(
                                      context,
                                      'Deletar',
                                      'Deseja deletar esse pagamento?',
                                    );
                                    if (result != true) return;
                                    controller.paymentRepository.remove(
                                      payment,
                                    );
                                  },
                                ),
                                onTap: () {
                                  // Get.toNamed(
                                  //   '/detailsInquilino',
                                  //   arguments: payment,
                                  // );
                                },
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                        itemCount: controller.lista.length,
                      ),
                    ),
                  );
          }),
        ],
      ),
    );
  }
}