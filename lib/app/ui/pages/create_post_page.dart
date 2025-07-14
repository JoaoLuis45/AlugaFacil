import 'package:aluga_facil/app/controllers/create_post_page_controller.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/ui/widgets/controllers/input_form_field_controller.dart';
import 'package:aluga_facil/app/ui/widgets/input_form_field.dart';
import 'package:aluga_facil/app/utils/mask_formatters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class CreatePostPage extends GetView<CreatePostController> {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: brownColorTwo,
          iconTheme: IconThemeData(color: goldColorThree),
          title: Text(
            'Criar Postagem',
            style: TextStyle(fontSize: 20, color: goldColorThree),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [brownColorTwo, goldColorTwo],
              begin: AlignmentDirectional.bottomStart,
              end: AlignmentDirectional.topEnd,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: Text(
                    'A foto da casa selecionada será usada como foto da postagem.',
                    style: TextStyle(
                      fontSize: 14,
                      color: goldColorThree,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: Get.width / 1.2,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: brownColorOne, width: 2),
                    gradient: LinearGradient(
                      colors: [goldColorOne, brownColorTwo],
                    ),
                  ),
                  child: Obx(() {
                    return controller.casa.value.fotoCasa == null ||
                            controller.casa.value.fotoCasa == ''
                        ? Icon(
                            Icons.house_rounded,
                            size: 50,
                            color: goldColorThree,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              controller.casa.value.fotoCasa!,
                              fit: BoxFit.cover,
                            ),
                          );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Text(
                    'Informações da Postagem',
                    style: TextStyle(
                      fontSize: 20,
                      color: goldColorThree,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  controller: controller.inputHouse,
                  onTap: () async {
                    controller.selectHouse(context);
                  },
                  readOnly: true,
                  style: const TextStyle(
                    color: goldColorTwo,
                    fontFamily: 'Raleway',
                  ),
                  decoration: InputDecoration(
                    fillColor: brownColorTwo,
                    filled: true,
                    labelText: 'Casa a ser postada',
                    labelStyle: TextStyle(color: goldColorTwo),
                    prefixIcon: Icon(Icons.house_outlined, color: goldColorTwo),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: goldColorTwo, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: goldColorTwo, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                MultiDropdown(
                  controller: controller.multiController,
                  items: controller.situationtList,
                  onSelectionChange: (selectedItems) {
                    if (selectedItems.isNotEmpty) {
                      controller.inputSituation.text =
                          selectedItems.first.name.capitalize!;
                    } else {
                      controller.inputSituation.text = '';
                    }
                  },
                  singleSelect: true,
                  searchEnabled: false,
                  fieldDecoration: FieldDecoration(
                    labelText: 'Situação do Imóvel',
                    showClearIcon: false,
                    suffixIcon: Icon(
                      Icons.arrow_drop_down_outlined,
                      color: goldColorTwo,
                    ),
                    hintStyle: TextStyle(color: goldColorTwo),
                    backgroundColor: brownColorTwo,
                    prefixIcon: Icon(Icons.post_add, color: goldColorTwo),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: goldColorTwo, width: 2),
                    ),
                    labelStyle: TextStyle(color: goldColorTwo),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: goldColorTwo, width: 2),
                    ),
                  ),
                  dropdownDecoration: DropdownDecoration(
                    backgroundColor: brownColorTwo,
                    elevation: 8,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  dropdownItemDecoration: DropdownItemDecoration(
                    textColor: goldColorTwo,
                    selectedTextColor: goldColorThree,
                    selectedBackgroundColor: brownColorOne,
                  ),
                ),
                SizedBox(height: 10),
                InputTextFormField(
                  keyy: 'contact',
                  maskformatter: [maskFormatterNumberPhone],
                  iconImage: Icons.smartphone,
                  keyboardType: TextInputType.phone,
                  isPassword: false,
                  textController: controller.inputContact,
                  title: 'Contato',
                  controller: InputFormFieldController(),
                ),
                SizedBox(height: 10),
                InputTextFormField(
                  keyy: 'value',
                  iconImage: Icons.monetization_on_outlined,
                  isPassword: false,
                  keyboardType: TextInputType.number,
                  textController: controller.inputValue,
                  title: 'Valor',
                  controller: InputFormFieldController(),
                ),
                SizedBox(height: 10),
                InputTextFormField(
                  keyy: 'obs',
                  iconImage: Icons.notes_outlined,
                  isPassword: false,
                  textController: controller.inputObs,
                  title: 'Observações',
                  controller: InputFormFieldController(),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [goldToBrownColor, brownColorTwo],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Obx(() {
                    return TextButton(
                      onPressed: () {
                        controller.savePost();
                      },
                      child: controller.isLoading
                          ? CircularProgressIndicator(color: goldColorOne)
                          : Text(
                              'Criar Postagem',
                              style: TextStyle(
                                color: goldColorThree,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                    );
                  }),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
