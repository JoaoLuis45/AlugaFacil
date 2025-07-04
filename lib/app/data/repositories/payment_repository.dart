import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:aluga_facil/app/data/models/payment_model.dart';
import 'package:aluga_facil/app/data/providers/payment_provider.dart';

class PaymentRepository {
  final PaymentProvider paymentProvider;

  PaymentRepository(this.paymentProvider);

  Future<void> save(PaymentModel payment) {
    return paymentProvider.save(payment);
  }

  Future<void> remove(PaymentModel payment) {
    return paymentProvider.remove(payment);
  }

  Future<void> read() {
    return paymentProvider.read();
  }

  Future<List<PaymentModel?>?> getInquilino(HouseModel casa) {
    return paymentProvider.getPaymentsByHouse(casa);
  }
}