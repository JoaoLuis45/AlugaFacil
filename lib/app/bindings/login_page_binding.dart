import 'package:aluga_facil/app/controllers/login_page_controller.dart';
import 'package:aluga_facil/app/data/providers/user_provider.dart';
import 'package:aluga_facil/app/data/repositories/user_repository.dart';
import 'package:get/instance_manager.dart';

class BindingLoginPage implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginPageController>(LoginPageController(UserRepository(UserProvider())));
  }
}
