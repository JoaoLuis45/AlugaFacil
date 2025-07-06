import 'package:aluga_facil/app/controllers/house_details_page_controller.dart';
import 'package:aluga_facil/app/data/models/inquilino_model.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/ui/widgets/visualize_form_field.dart';
import 'package:aluga_facil/app/utils/show_dialog_message.dart';
import 'package:aluga_facil/app/utils/showmessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HouseDetailsPage extends GetView<HouseDetailsPageController> {
  const HouseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: goldColorThree),
        centerTitle: true,
        title: Text(
          'Detalhes do imóvel',
          style: TextStyle(color: goldColorThree),
        ),
        backgroundColor: brownColorOne,
        actions: [
          IconButton(
            onPressed: () {
              Get.offNamed('/createHouse', arguments: controller.casa.value);
            },
            icon: Icon(Icons.edit_square, color: goldColorThree),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: 30),
            Center(
              child: Hero(
                tag: controller.casa.value,
                child: Obx(() {
                  return controller.casa.value.fotoCasa == null ||
                          controller.casa.value.fotoCasa == ''
                      ? CircleAvatar(
                          radius: 82,
                          backgroundColor: goldColorTwo,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: brownColorTwo,
                            child: Icon(
                              Icons.house,
                              color: goldColorThree,
                              size: 100,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 82,
                          backgroundColor: goldColorTwo,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(
                              controller.casa.value.fotoCasa!,
                            ),
                          ),
                        );
                }),
              ),
            ),
            SizedBox(height: 30),
            VisualizeTextFormField(
              textController: controller.inputNumeroCasa,
              keyy: 'numerocasa',
              iconImage: Icons.house,
              title: 'Número da Casa',
            ),
            SizedBox(height: 10),
            VisualizeTextFormField(
              textController: controller.inputLogradouro,
              keyy: 'logradouro',
              iconImage: Icons.location_on_sharp,
              title: 'Logradouro',
            ),
            SizedBox(height: 10),
            VisualizeTextFormField(
              textController: controller.inputBairro,
              keyy: 'bairro',
              iconImage: Icons.share_location,
              title: 'Bairro',
            ),
            SizedBox(height: 10),
            VisualizeTextFormField(
              textController: controller.inputCidade,
              keyy: 'cidade',
              iconImage: Icons.location_city_outlined,
              title: 'Cidade',
            ),
            SizedBox(height: 10),
            VisualizeTextFormField(
              textController: controller.inputvalorAluguel,
              keyy: 'valorAluguel',
              iconImage: Icons.attach_money_sharp,
              title: 'Valor do Aluguel',
            ),
            SizedBox(height: 10),
            Obx(() {
              return Visibility(
                visible: controller.casa.value.dataAluguel != null,
                child: VisualizeTextFormField(
                  textController: controller.inputDataAluguel,
                  keyy: 'dataAluguel',
                  iconImage: Icons.today_outlined,
                  title: 'Data do Aluguel',
                ),
              );
            }),
            SizedBox(height: 20),
            Obx(() {
              return controller.casa.value.inquilino == null
                  ? SizedBox(
                      width: Get.width,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.selectInquilino(context);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 12,
                          backgroundColor: brownColorOne,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'Adicionar Inquilino',
                          style: TextStyle(
                            color: goldColorThree,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : controller.isLoadingInquilino.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: brownColorTwo),
                      ],
                    )
                  : Column(
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
                              controller.inquilino.value.cpf ??
                                  'CPF do Inquilino',
                              style: TextStyle(
                                color: goldColorThree,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              controller.inquilino.value.nome ??
                                  'Nome do Inquilino',
                              style: TextStyle(
                                color: goldColorTwo,
                                fontSize: 16,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: goldColorThree),
                              onPressed: () async {
                                final result = await showDialogMessage(
                                  context,
                                  'Desvincular Inquilino',
                                  'Deseja desvincular esse inquilino?',
                                );
                                if (result != true) return;
                                controller.casa.value.inquilino = null;
                                controller.casa.value.dataAluguel = null;
                                await controller.inquilinoRepository.unsetCasa(
                                  controller.inquilino.value,
                                );
                                controller.inquilino.value = InquilinoModel();
                                await controller.houseRepository.unsetInquilino(
                                  controller.casa.value.id!,
                                );
                                controller.casa.update((a){});
                                showMessageBar(
                                  'Sucesso',
                                  'Inquilino desvinculado da casa!',
                                );
                              },
                            ),
                            onTap: () {
                              Get.offNamed(
                                '/detailsInquilino',
                                arguments: controller.inquilino.value,
                              );
                            },
                          ),
                        ),
                      ],
                    );
            }),
            SizedBox(height: 20),
            Obx(() {
              return Visibility(
                visible: controller.casa.value.inquilino != null,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Listagem de pagamentos',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: brownColorTwo,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: goldColorThree,
                            size: 30,
                          ),
                          onPressed: () {
                            Get.toNamed(
                              '/createPayment',
                              arguments: controller.casa.value,
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    controller.listPayments.isEmpty
                        ? Column(
                            children: [
                              SizedBox(height: 20),
                              Icon(
                                Icons.money_off,
                                color: brownColorTwo,
                                size: 48,
                              ),
                              Text(
                                'Nenhum pagamento encontrado.',
                                style: TextStyle(
                                  color: brownColorTwo,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 1),
                            itemCount: controller.listPayments.length,
                            itemBuilder: (context, index) {
                              final payment = controller.listPayments[index];
                              return Card(
                                color: brownColorTwo,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.attach_money,
                                    color: goldColorThree,
                                  ),
                                  title: Text(
                                    'R\$ ${payment.valor.toStringAsFixed(2)}',
                                    style: TextStyle(color: goldColorThree),
                                  ),
                                  subtitle: Text(
                                    '${payment.formaPagamento} - ${payment.dataPagamento.toLocal().toString().split(' ')[0]}',
                                    style: TextStyle(color: goldColorTwo),
                                  ),
                                  onTap: () {
                                    Get.offNamed(
                                      '/detailsPayment',
                                      arguments: payment,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                  ],
                ),
              );
            }),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
