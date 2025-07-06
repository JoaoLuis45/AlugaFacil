import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:aluga_facil/app/data/models/inquilino_model.dart';
import 'package:aluga_facil/app/data/models/payment_model.dart';
import 'package:aluga_facil/app/data/providers/payment_provider.dart';

class PaymentRepository {
  final PaymentProvider paymentProvider;

  PaymentRepository(this.paymentProvider);

  Future<void> save(PaymentModel payment) {
    return paymentProvider.save(payment);
  }

  Future<void> update(PaymentModel payment) {
    return paymentProvider.update(payment);
  }

  Future<void> remove(PaymentModel payment) {
    return paymentProvider.remove(payment);
  }

  Future<void> read() {
    return paymentProvider.read();
  }

  Future<List<PaymentModel?>?> getPaymentsByHouseAndInquilino(HouseModel casa, InquilinoModel inquilino) {
    return paymentProvider.getPaymentsByHouseAndInquilino(casa, inquilino);
  }

  Future<void> search(String search) {
    return paymentProvider.search(search);
  }

  Future<int> countPaymentsReceivedInCurrentMonth() {
    return paymentProvider.countPaymentsReceivedInCurrentMonth();
  }
  Future<double> countAmoutPaymentsReceivedInCurrentMonth() {
    return paymentProvider.countAmoutPaymentsReceivedInCurrentMonth();
  }
}