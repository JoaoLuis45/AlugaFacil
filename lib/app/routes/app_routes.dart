import 'package:aluga_facil/app/bindings/home_page_binding.dart';
import 'package:aluga_facil/app/bindings/login_page_binding.dart';
import 'package:aluga_facil/app/bindings/signup_page_binding.dart';
import 'package:aluga_facil/app/bindings/welcome_page_binding.dart';
import 'package:aluga_facil/app/ui/pages/createAccount/signup_page_view.dart';
import 'package:aluga_facil/app/ui/pages/home/home_page_view.dart';
import 'package:aluga_facil/app/ui/pages/login/login_page_view.dart';
import 'package:aluga_facil/app/ui/pages/welcome/welcome_page_view.dart';
import 'package:get/route_manager.dart';

final routes = [
  GetPage(name: '/', page: () => WelcomePage(), binding: BindingWelcomePage()),
  GetPage(name: '/login', page: () => LoginPage(), binding: BindingLoginPage()),
  GetPage(name: '/signup', page: () => SignUpPage(), binding: BindingSignUpPage()),
  GetPage(name: '/home', page: () => HomePage(), binding: HomePageBinding()),
];
