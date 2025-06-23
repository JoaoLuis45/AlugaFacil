import 'package:aluga_facil/app/pages/createAccount/controllers/signup_page_controller.dart';
import 'package:get/instance_manager.dart';

class BindingSignUpPage implements Bindings {
  @override
  void dependencies() {
    Get.put<SignupPageController>(SignupPageController());
  }
}
