import 'package:aluga_facil/app/pages/login/controllers/login_page_controller.dart';
import 'package:get/instance_manager.dart';

class BindingLoginPage implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginPageController>(LoginPageController());
  }
}
