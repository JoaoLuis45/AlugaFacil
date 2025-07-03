import 'package:aluga_facil/app/controllers/inquilino_page_controller.dart';
import 'package:aluga_facil/app/data/providers/inquilino_provider.dart';
import 'package:aluga_facil/app/data/repositories/inquilino_repository.dart';
import 'package:get/instance_manager.dart';

class InquilinoPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InquilinoPageController>(InquilinoPageController(InquilinoRepository(InquilinoProvider())));
  }
}
