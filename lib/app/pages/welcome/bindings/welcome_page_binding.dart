import 'package:aluga_facil/app/pages/welcome/controllers/welcome_page_controller.dart';
import 'package:get/instance_manager.dart';

class BindingWelcomePage implements Bindings {
  @override
  void dependencies() {
    Get.put<WelcomePageController>(WelcomePageController());
  }
}
