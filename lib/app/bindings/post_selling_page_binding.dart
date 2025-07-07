import 'package:aluga_facil/app/controllers/post_selling_page_controller.dart';
import 'package:get/get.dart';

class PostSellingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PostSellingPageController>(PostSellingPageController());
  }
}
