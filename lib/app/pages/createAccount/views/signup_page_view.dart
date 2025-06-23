import 'package:aluga_facil/app/pages/createAccount/controllers/signup_page_controller.dart';
import 'package:aluga_facil/app/shared/input_form_field.dart';
import 'package:aluga_facil/app/themes/app_colors.dart';
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
                          inputText(
                            'name',
                            'Nome Completo',
                            Icons.person_outline,
                            textController: controller.inputName,
                          ),
                          Spacer(flex: 2),
                          inputText(
                            'email',
                            'Email',
                            Icons.email_outlined,
                            textController: controller.inputEmail,
                          ),
                          Spacer(flex: 2),
                          inputText(
                            'pass',
                            'Senha',
                            Icons.lock_outline,
                            isPassword: true,
                            textController: controller.inputPassword,
                          ),
                          Spacer(flex: 2),
                          inputText(
                            'confirmpass',
                            'Confirmar Senha',
                            Icons.lock_reset,
                            isPassword: true,
                            textController: controller.inputPassword,
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
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Criar Conta',
                                style: TextStyle(
                                  color: goldColorThree,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
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
