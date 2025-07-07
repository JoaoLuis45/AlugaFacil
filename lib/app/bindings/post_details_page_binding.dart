import 'package:aluga_facil/app/controllers/post_details_page_controller.dart';
import 'package:get/get.dart';

class PostDetailsPageBinding implements Bindings{
  @override
   void dependencies() {
    Get.put<PostDetailsPageController>(PostDetailsPageController());
  }
}