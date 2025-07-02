import 'package:aluga_facil/app/controllers/house_controller.dart';
import 'package:aluga_facil/app/data/providers/house_provider.dart';
import 'package:aluga_facil/app/data/repositories/house_repository.dart';
import 'package:get/instance_manager.dart';

class HousePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HouseController(HouseRepository(HouseProvider())));
  }
}
