import 'package:aluga_facil/app/controllers/create_inquilino_page_controller.dart';
import 'package:aluga_facil/app/data/providers/inquilino_provider.dart';
import 'package:aluga_facil/app/data/repositories/inquilino_repository.dart';
import 'package:get/get.dart';

class CreateInquilinoPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CreateInquilinoPageController>(CreateInquilinoPageController(InquilinoRepository(InquilinoProvider())));
  }
}
