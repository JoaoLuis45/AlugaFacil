import 'package:aluga_facil/app/controllers/post_hiring_page_controller.dart';
import 'package:get/get.dart';

class PostHiringPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PostHiringPageController>(PostHiringPageController());
  }
}
