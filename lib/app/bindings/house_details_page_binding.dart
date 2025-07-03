import 'package:aluga_facil/app/controllers/house_details_page_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';

class HouseDetailsPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HouseDetailsPageController>(HouseDetailsPageController());
  }
}
