import 'package:aluga_facil/app/controllers/dashboard_page_controller.dart';
import 'package:aluga_facil/app/controllers/financeiro_page_controller.dart';
import 'package:aluga_facil/app/controllers/home_page_controller.dart';
import 'package:aluga_facil/app/controllers/house_controller.dart';
import 'package:aluga_facil/app/controllers/inquilino_page_controller.dart';
import 'package:aluga_facil/app/data/models/user_data_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final _loggedUser = UserDataModel().obs;
  UserDataModel get loggedUser => _loggedUser.value;
  set loggedUser(v) => _loggedUser.value = v;

  logout() {
    Get.offAllNamed('/welcome');
    Get.delete<HouseController>();
    Get.delete<InquilinoPageController>();
    Get.delete<FinanceiroPageController>();
    Get.delete<DashboardPageController>();
    Get.delete<HomePageController>();
  }
}
