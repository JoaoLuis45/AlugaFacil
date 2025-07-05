import 'package:aluga_facil/app/bindings/home_page_binding.dart';
import 'package:aluga_facil/app/bindings/welcome_page_binding.dart';
import 'package:aluga_facil/app/controllers/user_controller.dart';
import 'package:aluga_facil/app/data/providers/user_provider.dart';
import 'package:aluga_facil/app/data/repositories/user_repository.dart';
import 'package:aluga_facil/app/routes/app_routes.dart';
import 'package:aluga_facil/app/ui/pages/home_page.dart';
import 'package:aluga_facil/app/ui/pages/welcome_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = verifyPersistUser();
    return GetMaterialApp(
      title: 'AlugaFacil',
      debugShowCheckedModeBanner: false,
      initialBinding: user ? HomePageBinding() : BindingWelcomePage(),
      defaultTransition: Transition.fade,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: user ? HomePage() : WelcomePage(),
      getPages: routes,
    );
  }
}

bool verifyPersistUser() {
  final user = UserRepository(UserProvider()).getUserData();
  if (user != null) {
    Get.put<UserRepository>(UserRepository(UserProvider()));
    Get.put<UserController>(UserController());
  }
  return user != null;
}
