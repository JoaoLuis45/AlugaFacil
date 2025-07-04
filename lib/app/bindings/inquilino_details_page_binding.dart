import 'package:aluga_facil/app/controllers/inquilino_details_page_controller.dart';
import 'package:get/get.dart';

class InquilinoDetaisPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InquilinoDetailsPageController>(InquilinoDetailsPageController());
  }
}
