import 'package:aluga_facil/app/controllers/financeiro_page_controller.dart';
import 'package:aluga_facil/app/data/providers/payment_provider.dart';
import 'package:aluga_facil/app/data/repositories/payment_repository.dart';
import 'package:get/instance_manager.dart';

class FinanceiroPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FinanceiroPageController>(FinanceiroPageController(PaymentRepository(PaymentProvider())));
  }
}
