import 'package:aluga_facil/app/controllers/create_house_page_controller.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/ui/widgets/controllers/input_form_field_controller.dart';
import 'package:aluga_facil/app/ui/widgets/input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class CreateHousePage extends GetView<CreateHousePageController> {
  const CreateHousePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: brownColorTwo,
          iconTheme: IconThemeData(color: goldColorThree),
          title: Text(
            'Criar um novo imóvel',
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
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: Get.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 5),
                    Text(
                      'Foto da casa',
                      style: TextStyle(
                        fontSize: 20,
                        color: goldColorThree,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
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
                        return controller.isLoadingfotoCasa.value
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: goldColorThree,
                                  ),
                                ],
                              )
                            : controller.fotoCasa.value.isEmpty
                            ? IconButton(
                                onPressed: () {
                                  controller.switchHousePhoto();
                                },
                                icon: Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 50,
                                  color: goldColorThree,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  controller.switchHousePhoto();
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.network(
                                    controller.fotoCasa.value,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                      }),
                    ),
                    Spacer(flex: 3),
                    Text(
                      'Informações do Imóvel',
                      style: TextStyle(
                        fontSize: 20,
                        color: goldColorThree,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    InputTextFormField(
                      keyy: 'numCasa',
                      iconImage: Icons.house_outlined,
                      isPassword: false,
                      textController: controller.inputNumeroCasa,
                      title: 'Número da Casa',
                      controller: InputFormFieldController(),
                    ),
                    Spacer(),
                    InputTextFormField(
                      keyy: 'logradouro',
                      iconImage: Icons.location_on_sharp,
                      isPassword: false,
                      textController: controller.inputLogradouro,
                      title: 'Logradouro',
                      controller: InputFormFieldController(),
                    ),
                    Spacer(),
                    InputTextFormField(
                      keyy: 'bairro',
                      iconImage: Icons.share_location,
                      isPassword: false,
                      textController: controller.inputBairro,
                      title: 'Bairro',
                      controller: InputFormFieldController(),
                    ),
                    Spacer(),
                    InputTextFormField(
                      keyy: 'cidade',
                      iconImage: Icons.location_city_outlined,
                      isPassword: false,
                      textController: controller.inputCidade,
                      title: 'Cidade',
                      controller: InputFormFieldController(),
                    ),
                    Spacer(),
                    InputTextFormField(
                      keyy: 'valorAluguel',
                      iconImage: Icons.attach_money_sharp,
                      isPassword: false,
                      keyboardType: TextInputType.number,
                      textController: controller.inputvalorAluguel,
                      title: 'Valor do Aluguel',
                      controller: InputFormFieldController(),
                    ),
                    Spacer(flex: 5),
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
                            controller.saveHouse();
                          },
                          child: controller.isLoading
                              ? CircularProgressIndicator(color: goldColorOne)
                              : Text(
                                  controller.isEditing.value
                                      ? 'Editar Imóvel'
                                      : 'Criar Imóvel',
                                  style: TextStyle(
                                    color: goldColorThree,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                        );
                      }),
                    ),
                    Spacer(flex: 18),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
