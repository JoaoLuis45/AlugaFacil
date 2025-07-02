import 'package:aluga_facil/app/controllers/dashboard_page_controller.dart';
import 'package:get/instance_manager.dart';

class DashboardPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<DashboardPageController>(DashboardPageController());
  }
}
