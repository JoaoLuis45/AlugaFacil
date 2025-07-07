import 'package:aluga_facil/app/controllers/post_hiring_page_controller.dart';
import 'package:aluga_facil/app/controllers/post_page_controller.dart';
import 'package:aluga_facil/app/controllers/post_selling_page_controller.dart';
import 'package:get/instance_manager.dart';

class PostPageBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<PostSellingPageController>(PostSellingPageController());
    Get.put<PostHiringPageController>(PostHiringPageController());
    Get.put<PostPageController>(PostPageController());
  }
}