import 'package:aluga_facil/app/controllers/dashboard_page_controller.dart';
import 'package:aluga_facil/app/controllers/financeiro_page_controller.dart';
import 'package:aluga_facil/app/controllers/home_page_controller.dart';
import 'package:aluga_facil/app/controllers/house_controller.dart';
import 'package:aluga_facil/app/controllers/user_controller.dart';
import 'package:aluga_facil/app/data/providers/house_provider.dart';
import 'package:aluga_facil/app/data/providers/user_provider.dart';
import 'package:aluga_facil/app/data/repositories/house_repository.dart';
import 'package:aluga_facil/app/data/repositories/user_Repository.dart';
import 'package:get/instance_manager.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(UserController());
    Get.put<HouseController>(HouseController(HouseRepository(HouseProvider())));
    Get.put<FinanceiroPageController>(FinanceiroPageController());
    Get.put<DashboardPageController>(DashboardPageController());
    Get.put<HomePageController>(HomePageController(UserRepository(UserProvider())));
  }
}
