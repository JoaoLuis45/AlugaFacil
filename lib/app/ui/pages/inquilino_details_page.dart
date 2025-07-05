import 'package:aluga_facil/app/controllers/inquilino_details_page_controller.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/ui/widgets/visualize_form_field.dart';
import 'package:aluga_facil/app/utils/show_dialog_message.dart';
import 'package:aluga_facil/app/utils/showmessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InquilinoDetailsPage extends GetView<InquilinoDetailsPageController> {
  const InquilinoDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: goldColorThree),
        centerTitle: true,
        title: Text(
          'Detalhes do inquilino',
          style: TextStyle(color: goldColorThree),
        ),
        backgroundColor: brownColorOne,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(
                '/createInquilino',
                arguments: controller.inquilino.value,
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
                    tag: controller.inquilino.value,
                    child: CircleAvatar(
                      radius: 82,
                      backgroundColor: goldColorTwo,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: brownColorTwo,
                        child: Icon(
                          Icons.person,
                          color: goldColorThree,
                          size: 100,
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 3),
                VisualizeTextFormField(
                  textController: controller.inputNome,
                  keyy: 'nome',
                  iconImage: Icons.person_pin_outlined,
                  title: 'Número da Casa',
                ),
                Spacer(flex: 2),
                VisualizeTextFormField(
                  textController: controller.inputCpf,
                  keyy: 'cpf',
                  iconImage: Icons.numbers,
                  title: 'CPF',
                ),
                Spacer(flex: 2),
                VisualizeTextFormField(
                  textController: controller.inputCelular,
                  keyy: 'celular',
                  iconImage: Icons.smartphone,
                  title: 'Celular',
                ),
                Spacer(flex: 2),
                VisualizeTextFormField(
                  textController: controller.inputTelefone,
                  keyy: 'telefone',
                  iconImage: Icons.phone,
                  title: 'Telefone',
                ),
                Spacer(flex: 2),
                VisualizeTextFormField(
                  textController: controller.inputEmail,
                  keyy: 'email',
                  iconImage: Icons.email,
                  title: 'Email',
                ),
                Spacer(flex: 2),
                VisualizeTextFormField(
                  textController: controller.inputDataNascimento,
                  keyy: 'dataNascimento',
                  iconImage: Icons.today_outlined,
                  title: 'Data de Nascimento',
                ),
                Spacer(flex: 2),
                Obx(() {
                  return controller.inquilino.value.casaId == null
                      ? SizedBox(
                          width: Get.width,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.selectHouse(context);
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 12,
                              backgroundColor: brownColorOne,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              'Vincular à casa',
                              style: TextStyle(
                                color: goldColorThree,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Column(
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
                                leading: Icon(
                                  Icons.person,
                                  color: goldColorThree,
                                ),
                                title: Text(
                                  'Número da casa: ${controller.inquilino.value.casaNumero}',
                                  style: TextStyle(
                                    color: goldColorThree,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  controller.inquilino.value.casaId ?? '',
                                  style: TextStyle(
                                    color: goldColorTwo,
                                    fontSize: 16,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: goldColorThree,
                                  ),
                                  onPressed: () async {
                                    final result = await showDialogMessage(
                                      context,
                                      'Desvincular Casa',
                                      'Deseja desvincular essa casa?',
                                    );
                                    if (result != true) return;
                                    await controller.houseRepository
                                        .unsetInquilino(
                                          controller.inquilino.value.casaId!,
                                        );
                                    controller.inquilino.update((val) {
                                      val!.casaId = null;
                                      val.casaNumero = null;
                                    });
                                    await controller.inquilinoRepository
                                        .unsetCasa(controller.inquilino.value);
                                    showMessageBar(
                                      'Sucesso',
                                      'Casa desvinculada do usuário!',
                                    );
                                  },
                                ),
                                onTap: () {
                                  Get.offNamed(
                                    '/detailsHouse',
                                    arguments: controller.casa.value,
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
