import 'package:aluga_facil/app/controllers/financeiro_page_controller.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/utils/normal_date.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  helpText: 'Pesquisar por valor...',
                  boxShadow: true,
                  textFieldColor: goldColorThree,
                  searchIconColor: goldColorThree,
                  textFieldIconColor: brownColorTwo,
                  color: brownColorTwo,
                  textController: controller.searchController,
                  suffixIcon: const Icon(Icons.close, color: goldColorThree),
                  onSuffixTap: () {},
                  onSubmitted: (search) async {
                    await controller.paymentRepository.search(search);
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
                    Get.toNamed('/createPayment');
                  },
                  icon: Icon(
                    Icons.attach_money_rounded,
                    color: goldColorThree,
                    size: 32,
                  ),
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
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: brownColorTwo,
                            shape: CircleBorder(),
                          ),
                          icon: Icon(Icons.refresh, color: goldColorThree),
                          onPressed: () {
                            controller.paymentRepository.read();
                          },
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => controller.paymentRepository.read(),
                      child: Obx(() {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: controller.lista.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final payment = controller.lista[index];
                              return Obx(() {
                                return Card(
                                  color: goldColorThree,
                                  elevation: 8,
                                  child: ExpansionPanelList(
                                    expansionCallback: (i, isExpanded) {
                                      payment.isExpanded.value =
                                          !payment.isExpanded.value;
                                    },
                                    children: [
                                      ExpansionPanel(
                                        backgroundColor: goldColorThree,
                                        headerBuilder: (context, isExpanded) {
                                          return ListTile(
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
                                            subtitle: Text(
                                              formatDate(payment.dataPagamento),
                                            ),
                                          );
                                        },
                                        body: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Get.toNamed(
                                                  '/detailsPayment',
                                                  arguments: payment,
                                                );
                                              },
                                              icon: Icon(
                                                Icons.visibility_rounded,
                                                color: brownColorTwo,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.share,
                                                color: brownColorTwo,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.monetization_on_rounded,
                                                color: brownColorTwo,
                                              ),
                                            ),
                                          ],
                                        ),
                                        isExpanded: payment.isExpanded.value,
                                        canTapOnHeader: true,
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                          ),
                        );
                      }),
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
