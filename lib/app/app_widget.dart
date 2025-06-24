import 'package:aluga_facil/app/bindings/welcome_page_binding.dart';
import 'package:aluga_facil/app/routes/app_routes.dart';
import 'package:aluga_facil/app/services/flutter_fire_auth.dart';
import 'package:aluga_facil/app/ui/pages/welcome/welcome_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = FlutterFireAuth(context).getLoggedUser();
    return GetMaterialApp(
      title: 'AlugaFacil',
      debugShowCheckedModeBanner: false,
      // initialBinding: user != null ? HomePageBinding() : BindingWelcomePage(),
      initialBinding: BindingWelcomePage(),
      defaultTransition: Transition.fade,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      // home: user != null ? HomePage() :  WelcomePage(),
      home: WelcomePage(),
      getPages: routes,
    );
  }
}
