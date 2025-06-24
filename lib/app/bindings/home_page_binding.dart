import 'package:aluga_facil/app/controllers/home_page_controller.dart';
import 'package:get/instance_manager.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomePageController>(HomePageController());
  }
}
