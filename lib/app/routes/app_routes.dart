import 'package:aluga_facil/app/bindings/create_house_page_binding.dart';
import 'package:aluga_facil/app/bindings/create_inquilino_page_binding.dart';
import 'package:aluga_facil/app/bindings/create_payment_page_binding.dart';
import 'package:aluga_facil/app/bindings/create_post_page_binding.dart';
import 'package:aluga_facil/app/bindings/home_page_binding.dart';
import 'package:aluga_facil/app/bindings/house_details_page_binding.dart';
import 'package:aluga_facil/app/bindings/inquilino_details_page_binding.dart';
import 'package:aluga_facil/app/bindings/login_page_binding.dart';
import 'package:aluga_facil/app/bindings/payment_details_page_binding.dart';
import 'package:aluga_facil/app/bindings/post_details_page_binding.dart';
import 'package:aluga_facil/app/bindings/post_page_binding.dart';
import 'package:aluga_facil/app/bindings/signup_page_binding.dart';
import 'package:aluga_facil/app/bindings/welcome_page_binding.dart';
import 'package:aluga_facil/app/ui/pages/create_house_page.dart';
import 'package:aluga_facil/app/ui/pages/create_inquilino_page.dart';
import 'package:aluga_facil/app/ui/pages/create_payment_page.dart';
import 'package:aluga_facil/app/ui/pages/create_post_page.dart';
import 'package:aluga_facil/app/ui/pages/house_details_page.dart';
import 'package:aluga_facil/app/ui/pages/inquilino_details_page.dart';
import 'package:aluga_facil/app/ui/pages/payment_details_page.dart';
import 'package:aluga_facil/app/ui/pages/post_details_page.dart';
import 'package:aluga_facil/app/ui/pages/post_page.dart';
import 'package:aluga_facil/app/ui/pages/signup_page_view.dart';
import 'package:aluga_facil/app/ui/pages/home_page.dart';
import 'package:aluga_facil/app/ui/pages/login_page_view.dart';
import 'package:aluga_facil/app/ui/pages/welcome_page_view.dart';
import 'package:get/route_manager.dart';

final routes = [
  GetPage(name: '/welcome', page: () => WelcomePage(), binding: BindingWelcomePage()),
  GetPage(name: '/login', page: () => LoginPage(), binding: BindingLoginPage()),
  GetPage(name: '/signup', page: () => SignUpPage(), binding: BindingSignUpPage()),
  GetPage(name: '/home', page: () => HomePage(), binding: HomePageBinding()),
  GetPage(name: '/createHouse', page: () => CreateHousePage(), binding: CreateHousePageBinding()),
  GetPage(name: '/detailsHouse', page: () => HouseDetailsPage(), binding: HouseDetailsPageBinding()),
  GetPage(name: '/createInquilino', page: () => CreateInquilinoPage(), binding: CreateInquilinoPageBinding()),
  GetPage(name: '/detailsInquilino', page: () => InquilinoDetailsPage(), binding: InquilinoDetaisPageBinding()),
  GetPage(name: '/createPayment', page: () => CreatePaymentPage(), binding: CreatePaymentPageBinding()),
  GetPage(name: '/detailsPayment', page: () => PaymentDetailsPage(), binding: PaymentDetailsPageBinding()),
  GetPage(name: '/createPost', page: () => CreatePostPage(), binding: CreatePostBinding()),
  GetPage(name: '/posts', page: () => PostPage(), binding: PostPageBinding()),
  GetPage(name: '/detailsPosts', page: () => PostDetailsPage(), binding: PostDetailsPageBinding()),
];
