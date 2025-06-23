import 'package:aluga_facil/app/pages/createAccount/bindings/signup_page_binding.dart';
import 'package:aluga_facil/app/pages/createAccount/views/signup_page_view.dart';
import 'package:aluga_facil/app/pages/login/bindings/login_page_binding.dart';
import 'package:aluga_facil/app/pages/login/views/login_page_view.dart';
import 'package:aluga_facil/app/pages/welcome/bindings/welcome_page_binding.dart';
import 'package:aluga_facil/app/pages/welcome/views/welcome_page_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

final routes = [
  GetPage(name: '/', page: () => WelcomePage(),binding: BindingWelcomePage()),
  GetPage(name: '/login', page: () => LoginPage(),binding: BindingLoginPage()),
  GetPage(name: '/signup', page: () => SignUpPage(),binding: BindingSignUpPage()),
];
