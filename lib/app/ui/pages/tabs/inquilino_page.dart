import 'package:aluga_facil/app/controllers/inquilino_page_controller.dart';
import 'package:aluga_facil/app/data/models/inquilino_model.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/utils/show_dialog_message.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InquilinoPage extends GetView<InquilinoPageController> {
  const InquilinoPage({super.key});

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
                'Meus Inquilinos',
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
                  helpText: 'Pesquisar por nome...',
                  boxShadow: true,
                  textFieldColor: goldColorThree,
                  searchIconColor: goldColorThree,
                  textFieldIconColor: brownColorTwo,
                  color: brownColorTwo,
                  textController: controller.searchController,
                  suffixIcon: const Icon(Icons.close, color: goldColorThree),
                  onSuffixTap: () {},
                  onSubmitted: (search) async {
                    await controller.inquilinoRepository.search(search);
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
                    Get.toNamed('/createInquilino');
                  },
                  icon: Icon(Icons.person_add, color: goldColorThree, size: 32),
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
                          Icons.person_outline,
                          size: 100,
                          color: brownColorTwo,
                        ),
                        Text(
                          'Nenhum inquilino cadastrado',
                          style: TextStyle(
                            color: brownColorTwo,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.inquilinoRepository.read();
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: brownColorTwo,
                            shape: CircleBorder(),
                          ),
                          icon: Icon(Icons.refresh, color: goldColorThree),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => controller.inquilinoRepository.read(),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final InquilinoModel inquilino =
                              controller.lista[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Card(
                              color: goldColorThree,
                              elevation: 8,
                              child: ListTile(
                                leading: Hero(
                                  tag: inquilino,
                                  child: Icon(
                                    Icons.person,
                                    color: brownColorTwo,
                                    size: 64,
                                  ),
                                ),
                                title: Text(
                                  '${inquilino.nome} >> Casa: ${inquilino.casaNumero ?? 'Não vinculada'}',
                                ),
                                subtitle: Text(inquilino.cpf ?? ''),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: brownColorTwo,
                                  ),
                                  onPressed: () async {
                                    final result = await showDialogMessage(
                                      context,
                                      'Remover',
                                      'Deseja remover esse inquilino?',
                                    );
                                    if (result != true) return;
                                    controller.inquilinoRepository.remove(
                                      inquilino,
                                    );
                                  },
                                ),
                                onTap: () {
                                  Get.toNamed(
                                    '/detailsInquilino',
                                    arguments: inquilino,
                                  );
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
