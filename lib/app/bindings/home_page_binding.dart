import 'package:aluga_facil/app/controllers/home_page_controller.dart';
import 'package:aluga_facil/app/data/providers/user_provider.dart';
import 'package:aluga_facil/app/data/repositories/user_Repository.dart';
import 'package:get/instance_manager.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomePageController>(HomePageController(UserRepository(UserProvider())));
  }
}
