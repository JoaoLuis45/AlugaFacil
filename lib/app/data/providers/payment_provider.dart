import 'package:aluga_facil/app/controllers/financeiro_page_controller.dart';
import 'package:aluga_facil/app/controllers/inquilino_page_controller.dart';
import 'package:aluga_facil/app/controllers/user_controller.dart';
import 'package:aluga_facil/app/data/databases/db_firestore.dart';
import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:aluga_facil/app/data/models/inquilino_model.dart';
import 'package:aluga_facil/app/data/models/payment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';

class PaymentProvider {
  late FirebaseFirestore db;

  PaymentProvider() {
    _startProvider();
  }

  _startProvider() {
    _startFireStore();
  }

  _startFireStore() {
    db = DbFirestore.get();
  }

  Future<void> save(PaymentModel payment) async {
    final user = Get.find<UserController>();
    final paymentController = Get.find<FinanceiroPageController>();
    paymentController.lista.add(payment);
    await db
        .collection('usuarios/${user.loggedUser.id}/payments')
        .doc(payment.id.toString())
        .set({
          'casaId': payment.casaId,
          'dataPagamento': payment.dataPagamento,
          'formaPagamento': payment.formaPagamento,
          'id': payment.id,
          'inquilino': payment.inquilino,
          'valor': payment.valor,
        });
  }

  Future<void> update(PaymentModel payment) async {
    final user = Get.find<UserController>();
    final paymentController = Get.find<FinanceiroPageController>();
    paymentController.lista.add(payment);
    await db
        .collection('usuarios/${user.loggedUser.id}/payments')
        .doc(payment.id.toString())
        .set({
          'casaId': payment.casaId,
          'dataPagamento': payment.dataPagamento,
          'formaPagamento': payment.formaPagamento,
          'id': payment.id,
          'inquilino': payment.inquilino,
          'valor': payment.valor,
        },SetOptions(merge: true));
  }

  Future<void> read() async {
    try {
      final user = Get.find<UserController>();
      final paymentController = Get.find<FinanceiroPageController>();
      paymentController.isLoading.value = true;
      paymentController.lista.clear();
      final snapshot = await db
          .collection('usuarios/${user.loggedUser.id}/payments')
          .get();
      snapshot.docs.forEach((doc) {
        PaymentModel payment = PaymentModel(
          casaId: doc.get('casaId'),
          dataPagamento: (doc.get('dataPagamento') as Timestamp).toDate(),
          formaPagamento: doc.get('formaPagamento'),
          id: doc.get('id'),
          inquilino: doc.get('inquilino'),
          valor: doc.get('valor'),
        );
        paymentController.lista.add(payment);
      });
      paymentController.isLoading.value = false;
    } catch (e) {
      e.printError();
    }
  }

  Future<List<PaymentModel?>?> getPaymentsByHouseAndInquilino(HouseModel casa,InquilinoModel inquilino) async {
    try {
      final user = Get.find<UserController>();
      final snapshot = await db
          .collection('usuarios/${user.loggedUser.id}/payments')
          .where('casaId', isEqualTo: casa.id).where('inquilino', isEqualTo: inquilino.cpf)
          .get();

      List<PaymentModel> paymentList = [];

      snapshot.docs.forEach((doc) {
        PaymentModel payment = PaymentModel(
          casaId: doc.get('casaId'),
          dataPagamento: (doc.get('dataPagamento') as Timestamp).toDate(),
          formaPagamento: doc.get('formaPagamento'),
          id: doc.get('id'),
          inquilino: doc.get('inquilino'),
          valor: doc.get('valor'),
        );
        paymentList.add(payment);
      });

      return paymentList;
    } catch (e) {
      e.printError();
    }
    return null;
  }

  Future<void> search(String search) async {
    try {
      final user = Get.find<UserController>();
      final paymentController = Get.find<FinanceiroPageController>();
      paymentController.isLoading.value = true;
      paymentController.lista.clear();
      final snapshot = await db
          .collection('usuarios/${user.loggedUser.id}/payments')
          .where('valor', isGreaterThanOrEqualTo: int.tryParse(search)).get();
      snapshot.docs.forEach((doc) {
         PaymentModel payment = PaymentModel(
          casaId: doc.get('casaId'),
          dataPagamento: (doc.get('dataPagamento') as Timestamp).toDate(),
          formaPagamento: doc.get('formaPagamento'),
          id: doc.get('id'),
          inquilino: doc.get('inquilino'),
          valor: doc.get('valor'),
        );
        paymentController.lista.add(payment);
      });
      paymentController.isLoading.value = false;
    } catch (e) {
      //showMessageBar('Erro!', e.toString());
      e.printError();
    }
  }

  Future<void> remove(PaymentModel payment) async {
    final paymentController = Get.find<FinanceiroPageController>();
    final user = Get.find<UserController>();
    await db
        .collection('usuarios/${user.loggedUser.id}/payments')
        .doc(payment.id.toString())
        .delete();
    paymentController.lista.remove(payment);
  }
}
