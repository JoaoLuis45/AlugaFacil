import 'package:aluga_facil/app/controllers/post_details_page_controller.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/ui/widgets/visualize_form_field.dart';
import 'package:aluga_facil/app/utils/show_dialog_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';

class PostDetailsPage extends GetView<PostDetailsPageController> {
  const PostDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: goldColorThree),
        centerTitle: true,
        title: Text(
          'Detalhes da Postagem',
          style: TextStyle(color: goldColorThree),
        ),
        backgroundColor: brownColorOne,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: 30),
            Center(
              child: Hero(
                tag: controller.post.value,
                child: Obx(() {
                  return controller.post.value.house!.fotoCasa == null ||
                          controller.post.value.house!.fotoCasa == ''
                      ? CircleAvatar(
                          radius: 82,
                          backgroundColor: goldColorTwo,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: brownColorTwo,
                            child: Icon(
                              Icons.photo_size_select_actual_outlined,
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
                              controller.post.value.house!.fotoCasa!,
                            ),
                          ),
                        );
                }),
              ),
            ),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: FlutterToggleTab(
                    width: 90, // width in percent
                    borderRadius: 10,
                    height: 35,
                    selectedIndex: controller.tabIndex.value,
                    selectedBackgroundColors: [goldColorThree, goldColorTwo],
                    selectedTextStyle: TextStyle(
                      color: goldToBrownColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    unSelectedTextStyle: TextStyle(
                      color: brownColorTwo,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    dataTabs: controller.listTabs,
                    selectedLabelIndex: (index) async {
                      controller.tabIndex.value = index;
                      if(index != 0){
                        final result = await showDialogMessage(
                        context,
                        'Tem ceteza?',
                        'A postagem sairá de circulação, deseja continuar ?',
                      );
                      if (result != true) return;
                      controller.alterStatusPost();   
                      }
                      
                    },
                    isScroll: false,
                  ),
                ),
              );
            }),
            Obx(() {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Imóvel Vinculado',
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
                        '${controller.post.value.house!.numeroCasa} - ${controller.post.value.house!.bairro}',
                        style: TextStyle(
                          color: goldColorThree,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${controller.post.value.house!.logradouro} - ${controller.post.value.house!.cidade}',
                        style: TextStyle(color: goldColorTwo, fontSize: 16),
                      ),
                      onTap: () {
                        Get.offNamed(
                          '/detailsHouse',
                          arguments: controller.post.value.house,
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 20),
            VisualizeTextFormField(
              textController: controller.inputSituation,
              keyy: 'situation',
              iconImage: Icons.post_add,
              title: 'Situação',
            ),
            SizedBox(height: 10),
            VisualizeTextFormField(
              textController: controller.inputValue,
              keyy: 'valor',
              iconImage: Icons.monetization_on,
              title: 'Valor',
            ),
            SizedBox(height: 10),
            VisualizeTextFormField(
              textController: controller.inputPostDate,
              keyy: 'postDate',
              iconImage: Icons.today_outlined,
              title: 'Data da Postagem',
            ),
            SizedBox(height: 10),
            VisualizeTextFormField(
              textController: controller.inputContact,
              keyy: 'contact',
              iconImage: Icons.smartphone,
              title: 'Contato',
            ),
            SizedBox(height: 10),
            VisualizeTextFormField(
              textController: controller.inputObs,
              keyy: 'obs',
              iconImage: Icons.notes_outlined,
              title: 'Observações',
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
