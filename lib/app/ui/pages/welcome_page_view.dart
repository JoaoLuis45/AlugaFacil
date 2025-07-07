import 'package:aluga_facil/app/controllers/welcome_page_controller.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends GetView<WelcomePageController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [goldToBrownColor, brownColorTwo]),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 32),
          child: Column(
            children: [
              Spacer(flex: 10),
              Image.asset('assets/logoAlugaFacilTransparent.png', height: 150),
              Spacer(flex: 10),
              Text(
                'Bem Vindo de Volta',
                style: GoogleFonts.inter(
                  color: goldColorThree,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(flex: 5),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: BoxBorder.all(color: goldColorOne, width: 2),
                ),
                child: TextButton(
                  onPressed: () {
                    Get.offAllNamed('/login');
                    Get.offAllNamed('/login');
                  },
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      color: goldColorThree,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Spacer(flex: 2),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: goldColorThree,
                ),
                child: TextButton(
                  onPressed: () {
                    Get.offAllNamed('/signup');
                    Get.offAllNamed('/signup');
                  },
                  child: Text(
                    'Criar Conta',
                    style: TextStyle(
                      color: brownColorTwo,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Spacer(flex: 10),
              Text(
                'Nossas Redes Sociais',
                style: TextStyle(color: goldColorThree, fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.launcherInBrowser(Uri.parse('https://www.facebook.com'));

                    },
                    icon: Icon(Icons.facebook, color: goldColorThree, size: 40),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.launcherInBrowser(Uri.parse('https://www.instagram.com/joaoluis_ramos/'));
                    },
                    icon: Icon(Icons.inbox, color: goldColorThree, size: 40),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.launcherInBrowser(Uri.parse('mailto:joaoluisramos45@gmail.com'));
                    },
                    icon: Icon(Icons.email, color: goldColorThree, size: 40),
                  ),
                ],
              ),
              Spacer(flex: 6),
            ],
          ),
        ),
      ),
    );
  }
}
