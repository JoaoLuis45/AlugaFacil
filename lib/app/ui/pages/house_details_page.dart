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
            onPressed: () {},
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
                Spacer(flex: 3),
                VisualizeTextFormField(
                  textController: controller.inputNumeroCasa,
                  keyy: 'numerocasa',
                  iconImage: Icons.house,
                  title: 'Número da Casa',
                ),
                Spacer(flex: 2),
                VisualizeTextFormField(
                  textController: controller.inputLogradouro,
                  keyy: 'logradouro',
                  iconImage: Icons.location_on_sharp,
                  title: 'Logradouro',
                ),
                Spacer(flex: 2),
                VisualizeTextFormField(
                  textController: controller.inputBairro,
                  keyy: 'bairro',
                  iconImage: Icons.share_location,
                  title: 'Bairro',
                ),
                Spacer(flex: 2),
                VisualizeTextFormField(
                  textController: controller.inputCidade,
                  keyy: 'cidade',
                  iconImage: Icons.location_city_outlined,
                  title: 'Cidade',
                ),
                Spacer(flex: 2),
                VisualizeTextFormField(
                  textController: controller.inputvalorAluguel,
                  keyy: 'valorAluguel',
                  iconImage: Icons.attach_money_sharp,
                  title: 'Valor do Aluguel',
                ),
                Spacer(flex: 2),
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
                      ? CircularProgressIndicator(color: brownColorTwo)
                      : Card(
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
                                controller.casa.update((val) {
                                  val!.inquilino = null;
                                });
                                await controller.inquilinoRepository.unsetCasa(
                                  controller.inquilino.value,
                                );
                                controller.inquilino.value = InquilinoModel();
                                await controller.houseRepository.unsetInquilino(
                                  controller.casa.value.id!,
                                );
                                showMessageBar(
                                  'Sucesso',
                                  'Inquilino desvinculado da casa!',
                                );
                              },
                            ),
                          ),
                        );
                }),
                Spacer(flex: 5),
                Obx(() {
                  return Visibility(
                    visible: controller.casa.value.inquilino != null,
                    child: Column(
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
                        SizedBox(height: 10),
                        ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Card(
                              elevation: 8,
                              color: goldColorThree,
                              child: ListTile(
                                leading: Icon(
                                  Icons.payment,
                                  color: brownColorTwo,
                                ),
                                title: Text(
                                  'Pagamento 1',
                                  style: TextStyle(
                                    color: brownColorTwo,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'Valor do Pagamento',
                                  style: TextStyle(
                                    color: brownColorOne,
                                    fontSize: 16,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.visibility_rounded,
                                    color: brownColorTwo,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            Card(
                              elevation: 8,
                              color: goldColorThree,
                              child: ListTile(
                                leading: Icon(
                                  Icons.payment,
                                  color: brownColorTwo,
                                ),
                                title: Text(
                                  'Pagamento 2',
                                  style: TextStyle(
                                    color: brownColorTwo,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'Valor do Pagamento 2',
                                  style: TextStyle(
                                    color: brownColorOne,
                                    fontSize: 16,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.visibility_rounded,
                                    color: brownColorTwo,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
                Spacer(flex: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
