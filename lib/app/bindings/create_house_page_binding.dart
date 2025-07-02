import 'package:aluga_facil/app/controllers/create_house_page_controller.dart';
import 'package:aluga_facil/app/data/providers/house_provider.dart';
import 'package:aluga_facil/app/data/repositories/house_repository.dart';
import 'package:get/get.dart';

class CreateHousePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CreateHousePageController>(CreateHousePageController(HouseRepository(HouseProvider())));
  }
}
