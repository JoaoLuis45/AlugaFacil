import 'package:aluga_facil/app/bindings/create_house_page_binding.dart';
import 'package:aluga_facil/app/bindings/home_page_binding.dart';
import 'package:aluga_facil/app/bindings/login_page_binding.dart';
import 'package:aluga_facil/app/bindings/signup_page_binding.dart';
import 'package:aluga_facil/app/bindings/welcome_page_binding.dart';
import 'package:aluga_facil/app/ui/pages/create_house.dart';
import 'package:aluga_facil/app/ui/pages/signup_page_view.dart';
import 'package:aluga_facil/app/ui/pages/home_page_view.dart';
import 'package:aluga_facil/app/ui/pages/login_page_view.dart';
import 'package:aluga_facil/app/ui/pages/welcome_page_view.dart';
import 'package:get/route_manager.dart';

final routes = [
  GetPage(name: '/welcome', page: () => WelcomePage(), binding: BindingWelcomePage()),
  GetPage(name: '/login', page: () => LoginPage(), binding: BindingLoginPage()),
  GetPage(name: '/signup', page: () => SignUpPage(), binding: BindingSignUpPage()),
  GetPage(name: '/home', page: () => HomePage(), binding: HomePageBinding()),
  GetPage(name: '/createHouse', page: () => CreateHousePage(), binding: CreateHousePageBinding()),
];
