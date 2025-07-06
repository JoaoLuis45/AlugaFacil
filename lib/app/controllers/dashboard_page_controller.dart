import 'package:aluga_facil/app/data/providers/house_provider.dart';
import 'package:aluga_facil/app/data/providers/inquilino_provider.dart';
import 'package:aluga_facil/app/data/providers/payment_provider.dart';
import 'package:aluga_facil/app/data/repositories/house_repository.dart';
import 'package:aluga_facil/app/data/repositories/inquilino_repository.dart';
import 'package:aluga_facil/app/data/repositories/payment_repository.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPageController extends GetxController {
  TooltipBehavior? tooltipBehavior;

  final HouseRepository houseRepository = HouseRepository(HouseProvider());
  final InquilinoRepository inquilinoRepository = InquilinoRepository(
    InquilinoProvider(),
  );
  final PaymentRepository paymentRepository = PaymentRepository(
    PaymentProvider(),
  );

  final totalPaymentsReceivedNumber = 0.obs;
  final totalPaymentsReceivedAmout = 0.0.obs;

  final totalPaymentsPendingNumber = 0.obs;
  final totalPaymentsPendingAmout = 0.0.obs;

  final totalHousesAvailable = 0.obs;
  final totalHousesRented = 0.obs;

  @override
  void onInit() async {
    tooltipBehavior = TooltipBehavior(enable: true);
    await getDatas();
    super.onInit();
  }

  getDatas() async {
    totalPaymentsReceivedNumber.value = await paymentRepository
        .countPaymentsReceivedInCurrentMonth();
    totalPaymentsReceivedAmout.value = await paymentRepository
        .countAmoutPaymentsReceivedInCurrentMonth();

    totalHousesAvailable.value = await houseRepository.getTotalHousesAvailable();
    totalHousesRented.value = await houseRepository.getTotalHousesRented();
  }

  String getCurrentMonthNamePtBr() {
    const monthNames = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];
    final now = DateTime.now();
    return monthNames[now.month - 1];
  }
}

class PaymentsData {
  final String month;
  final double amount;

  PaymentsData(this.month, this.amount);
}

class PaymentsTypeData {
  final String type;
  final double amount;

  PaymentsTypeData(this.type, this.amount);
}
