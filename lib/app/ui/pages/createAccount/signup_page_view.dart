import 'package:aluga_facil/app/controllers/signup_page_controller.dart';
import 'package:aluga_facil/app/ui/widgets/controllers/input_form_field_controller.dart';
import 'package:aluga_facil/app/ui/widgets/input_form_field.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends GetView<SignupPageController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [goldToBrownColor, brownColorTwo]),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: Get.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(flex: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Crie Sua',
                            style: GoogleFonts.inter(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: goldColorThree,
                            ),
                          ),
                          Text(
                            'Conta!',
                            style: GoogleFonts.inter(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: goldColorThree,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Image.asset(
                          'assets/logoAlugaFacilTransparent.png',
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 5),
                Expanded(
                  flex: 30,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: goldColorTwo,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        children: [
                          Spacer(flex: 20),
                          InputTextFormField(
                            keyy: 'name',
                            iconImage: Icons.person_outline,
                            isPassword: false,
                            textController: controller.inputName,
                            title: 'Nome de usuário',
                            controller: InputFormFieldController(),
                          ),
                          Spacer(flex: 2),
                          InputTextFormField(
                            keyy: 'email',
                            iconImage: Icons.email_outlined,
                            isPassword: false,
                            textController: controller.inputEmail,
                            title: 'Email',
                            controller: InputFormFieldController(),
                          ),
                          Spacer(flex: 2),
                          InputTextFormField(
                            keyy: 'pass',
                            iconImage: Icons.lock_outline,
                            isPassword: true,
                            textController: controller.inputPassword,
                            title: 'Senha',
                            controller: InputFormFieldController(),
                          ),
                          Spacer(flex: 2),
                          InputTextFormField(
                            keyy: 'confirmPass',
                            iconImage: Icons.lock_reset,
                            isPassword: true,
                            textController: controller.inputConfirmPassword,
                            title: 'Confirmação de Senha',
                            controller: InputFormFieldController(),
                          ),
                          Spacer(flex: 10),
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
                                  controller.onSubmit(context);
                                },
                                child: controller.isLoading
                                    ? CircularProgressIndicator(
                                        color: goldColorOne,
                                      )
                                    : Text(
                                        'Criar Conta',
                                        style: TextStyle(
                                          color: goldColorThree,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                              );
                            }),
                          ),
                          Spacer(flex: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Já tem uma conta?',
                                style: TextStyle(
                                  color: goldColorThree,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.offAllNamed('/login');
                                },
                                child: Text(
                                  'Entrar',
                                  style: TextStyle(
                                    color: brownColorTwo,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(flex: 5),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
