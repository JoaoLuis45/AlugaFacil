import 'package:aluga_facil/app/controllers/house_controller.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/utils/show_dialog_message.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HousePage extends GetView<HouseController> {
  const HousePage({super.key});

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
                'Meus imóveis',
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
                  helpText: 'Pesquisar Imóvel...',
                  boxShadow: true,
                  textFieldColor: goldColorThree,
                  searchIconColor: goldColorThree,
                  textFieldIconColor: brownColorTwo,
                  color: brownColorTwo,
                  textController: controller.searchController,
                  suffixIcon: const Icon(Icons.close, color: goldColorThree),
                  onSuffixTap: () {},
                  onSubmitted: (search) async{
                    await controller.houseRepository.searchHouse(search);
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
                    Get.toNamed('/createHouse');
                  },
                  icon: Icon(
                    Icons.add_home_rounded,
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
                          Icons.house_outlined,
                          size: 100,
                          color: brownColorTwo,
                        ),
                        Text(
                          'Nenhuma casa cadastrada',
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
                      onRefresh: () => controller.houseRepository.read(),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final casa = controller.lista[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Card(
                              color: goldColorThree,
                              elevation: 8,

                              child: ListTile(
                                leading: Hero(
                                  tag: casa,
                                  child:
                                      casa.fotoCasa != null &&
                                          casa.fotoCasa != ''
                                      ? CircleAvatar(
                                          radius: 32,
                                          backgroundImage: NetworkImage(
                                            casa.fotoCasa,
                                          ),
                                        )
                                      : Icon(
                                          Icons.house,
                                          color: brownColorTwo,
                                          size: 64,
                                        ),
                                ),
                                title: Text(
                                  '${casa.numeroCasa} - ${casa.logradouro}',
                                ),
                                subtitle: Text(
                                  'R\$ ${casa.valorAluguel.toStringAsFixed(2)} >> ${casa.inquilino != null ? 'Alugada' : 'Disponível'}',
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: brownColorTwo,
                                  ),
                                  onPressed: () async {
                                    final result = await showDialogMessage(
                                      context,
                                      'Remover',
                                      'Deseja remover essa casa?',
                                    );
                                    if (result != true) return;
                                    controller.houseRepository.remove(casa);
                                  },
                                ),
                                onTap: () {
                                  Get.toNamed('/detailsHouse', arguments: casa);
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
