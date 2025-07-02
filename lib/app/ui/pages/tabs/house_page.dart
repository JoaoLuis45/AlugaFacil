import 'package:aluga_facil/app/controllers/house_controller.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HousePage extends GetView<HouseController> {
  const HousePage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.houseRepository.readCasas();
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimSearchBar(
                  width: Get.width / 100 * 92,
                  helpText: 'Pesquisar Imóvel...',
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
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final casa = controller.lista[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              casa.fotoCasa ??
                                  'https://via.placeholder.com/150',
                            ),
                          ),
                          title: Text(
                            '${casa.numeroCasa} - ${casa.logradouro}',
                          ),
                          subtitle: Text(
                            'R\$ ${casa.valorAluguel.toStringAsFixed(2)}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              controller.houseRepository.remove(casa);
                            },
                          ),
                          onTap: () {
                            Get.toNamed('/houseDetails', arguments: casa);
                          },
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: controller.lista.length,
                    ),
                  );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/createHouse');
        },
        backgroundColor: brownColorTwo,

        child: const Icon(Icons.add, color: goldColorOne),
      ),
    );
  }
}
