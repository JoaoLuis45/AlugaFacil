import 'package:aluga_facil/app/pages/welcome/bindings/welcome_page_binding.dart';
import 'package:aluga_facil/app/pages/welcome/views/welcome_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AlugaFacil',
      debugShowCheckedModeBanner: false,
      initialBinding: BindingWelcomePage(),
      defaultTransition: Transition.fade,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: const WelcomePage(),
    );
  }
}
