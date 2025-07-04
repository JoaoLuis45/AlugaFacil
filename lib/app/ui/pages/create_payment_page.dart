import 'package:aluga_facil/app/controllers/create_payment_page_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

class CreatePaymentPage extends GetView<CreatePaymentPageController> {
  const CreatePaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: brownColorTwo,
          iconTheme: IconThemeData(color: goldColorThree),
          title: Text(
            'Cadastrar um novo inquilino',
            style: TextStyle(fontSize: 20, color: goldColorThree),
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add_home))],
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
                      'Informações do Inquilino',
                      style: TextStyle(
                        fontSize: 20,
                        color: goldColorThree,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    InputTextFormField(
                      keyy: 'nome',
                      iconImage: Icons.person,
                      isPassword: false,
                      textController: controller.inputNome,
                      title: 'Nome',
                      controller: InputFormFieldController(),
                    ),
                    Spacer(),
                    InputTextFormField(
                      keyy: 'cpf',
                      maskformatter: [maskFormatterCPF],
                      iconImage: Icons.numbers,
                      isPassword: false,
                      textController: controller.inputCpf,
                      title: 'CPF',
                      controller: InputFormFieldController(),
                    ),
                    Spacer(),
                    InputTextFormField(
                      keyy: 'celular',
                      maskformatter: [maskFormatterNumberPhone],
                      iconImage: Icons.smartphone,
                      isPassword: false,
                      textController: controller.inputCelular,
                      title: 'Celular',
                      controller: InputFormFieldController(),
                    ),
                    Spacer(),
                    InputTextFormField(
                      keyy: 'telefone',
                      maskformatter: [maskFormatterNumberPhone],
                      iconImage: Icons.phone,
                      isPassword: false,
                      textController: controller.inputTelefone,
                      title: 'Telefone',
                      controller: InputFormFieldController(),
                    ),
                    Spacer(),
                    InputTextFormField(
                      keyy: 'email',
                      iconImage: Icons.email,
                      isPassword: false,
                      textController: controller.inputEmail,
                      title: 'Email',
                      controller: InputFormFieldController(),
                    ),
                    Spacer(),
                    TextFormField(
                      controller: controller.inputDataNascimento,
                      inputFormatters: [maskFormatterDate],
                      onTap: () async {
                        List<DateTime?>? results =
                            await showCalendarDatePicker2Dialog(
                              context: context,
                              config:
                                  CalendarDatePicker2WithActionButtonsConfig(),
                              dialogSize: const Size(325, 400),
                              value: _dates,
                              borderRadius: BorderRadius.circular(15),
                            );
                        if (results != null && results.isNotEmpty) {
                          controller.inputDataNascimento.text = formatDate(results.first);
                          controller.dataNascimento = results.first.toString();
                        }
                      },
                      readOnly: true,
                      style: const TextStyle(
                        color: goldColorTwo,
                        fontFamily: 'Raleway',
                      ),
                      decoration: InputDecoration(
                        fillColor: brownColorTwo,
                        filled: true,
                        labelText: 'Data de Nascimento',
                        labelStyle: TextStyle(color: goldColorTwo),
                        prefixIcon: Icon(
                          Icons.today_outlined,
                          color: goldColorTwo,
                        ),
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
                            controller.saveInquilino();
                          },
                          child: controller.isLoading
                              ? CircularProgressIndicator(color: goldColorOne)
                              : Text(
                                  'Salvar Inquilino',
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
    );;
  }
}