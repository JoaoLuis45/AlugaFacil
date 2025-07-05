import 'package:aluga_facil/app/controllers/payment_details_page_controller.dart';
import 'package:get/instance_manager.dart';

class PaymentDetailsPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PaymentDetailsPageController>(PaymentDetailsPageController());
  }
}
