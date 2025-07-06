import 'package:aluga_facil/app/controllers/dashboard_page_controller.dart';
import 'package:aluga_facil/app/controllers/financeiro_page_controller.dart';
import 'package:aluga_facil/app/controllers/inquilino_page_controller.dart';
import 'package:aluga_facil/app/controllers/user_controller.dart';
import 'package:aluga_facil/app/data/databases/db_firestore.dart';
import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:aluga_facil/app/data/models/inquilino_model.dart';
import 'package:aluga_facil/app/data/models/payment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
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
        }, SetOptions(merge: true));
  }

  Future<void> read() async {
    try {
      final user = Get.find<UserController>();
      final paymentController = Get.find<FinanceiroPageController>();
      List payments = [];
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
        payments.add(payment);
      });
      paymentController.lista.assignAll(payments);
      paymentController.isLoading.value = false;
    } catch (e) {
      e.printError();
    }
  }

  Future<List<PaymentModel?>?> getPaymentsByHouseAndInquilino(
    HouseModel casa,
    InquilinoModel inquilino,
  ) async {
    try {
      final user = Get.find<UserController>();
      final snapshot = await db
          .collection('usuarios/${user.loggedUser.id}/payments')
          .where('casaId', isEqualTo: casa.id)
          .where('inquilino', isEqualTo: inquilino.cpf)
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
          .where('valor', isGreaterThanOrEqualTo: int.tryParse(search))
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

  Future<void> paymentsReceivedInCurrentMonth() async {
    try {
      final user = Get.find<UserController>();
      final dashboardController = Get.find<DashboardPageController>();
      final now = DateTime.now().toUtc();
      final snapshot2 = await db
          .collection('usuarios/${user.loggedUser.id}/payments')
          .where(
            'dataPagamento',
            isGreaterThanOrEqualTo: Timestamp.fromDate(
              DateTime.utc(now.year, now.month, 1),
            ),
          )
          .where(
            'dataPagamento',
            isLessThan: Timestamp.fromDate(
              DateTime.utc(now.year, now.month + 1, 1),
            ),
          )
          .get();

      double totalAmount = 0.0;
      snapshot2.docs.forEach((doc) {
        totalAmount += doc.get('valor')?.toDouble() ?? 0.0;
      });
      dashboardController.totalPaymentsReceivedAmout.value = totalAmount;
      dashboardController.totalPaymentsReceivedNumber.value =
          snapshot2.docs.length;
    } catch (e) {
      e.printError();
    }
  }

  Future<void> paymentsPendingInCurrentMonthAndTenantsSituation() async {
    try {
      final user = Get.find<UserController>();
      final dashboardController = Get.find<DashboardPageController>();
      final now = DateTime.now().toUtc();
      double totalAmoutPending = 0.0;
      int totalNumberPending = 0;
      final snapshot2 = await db
          .collection('usuarios/${user.loggedUser.id}/imoveis')
          .get();

      if (snapshot2.docs.isEmpty) {
        return;
      }

      final List<HouseModel> casas = snapshot2.docs
          .map((doc) => HouseModel.fromJson(doc.data()))
          .cast<HouseModel>()
          .toList();

      for (var casa in casas) {
        if (casa.inquilino == null) {
          continue;
        }
        final diaAluguel = casa.dataAluguel!.day;
        if (diaAluguel > now.day) {
          continue;
        }
        final snapshot = await db
            .collection('usuarios/${user.loggedUser.id}/payments')
            .where('casaId', isEqualTo: casa.id)
            .where(
              'dataPagamento',
              isGreaterThanOrEqualTo: Timestamp.fromDate(
                DateTime.utc(now.year, now.month, 1),
              ),
            )
            .where(
              'dataPagamento',
              isLessThan: Timestamp.fromDate(
                DateTime.utc(now.year, now.month + 1, 1),
              ),
            )
            .get();
        if (snapshot.docs.isEmpty) {
          totalAmoutPending += casa.valorAluguel!.toDouble();
          totalNumberPending++;
        }
      }

      final snapshot3 = await db
          .collection('usuarios/${user.loggedUser.id}/inquilinos')
          .get();
      dashboardController.totalPaymentsPendingAmout.value = totalAmoutPending;
      dashboardController.totalPaymentsPendingNumber.value = totalNumberPending;
      dashboardController.totalTenantsOwing.value = totalNumberPending;
      dashboardController.totalTenantsUpToDate.value =
          snapshot3.size - totalNumberPending;
    } catch (e) {
      e.printError();
    }
  }

  Future<void> paymentsReceivedInCurrentMonthPerType() async {
    try {
      final user = Get.find<UserController>();
      final dashboardController = Get.find<DashboardPageController>();
      final now = DateTime.now().toUtc();
      final snapshot2 = await db
          .collection('usuarios/${user.loggedUser.id}/payments')
          .where(
            'dataPagamento',
            isGreaterThanOrEqualTo: Timestamp.fromDate(
              DateTime.utc(now.year, now.month, 1),
            ),
          )
          .where(
            'dataPagamento',
            isLessThan: Timestamp.fromDate(
              DateTime.utc(now.year, now.month + 1, 1),
            ),
          )
          .get();

      int dinheiro = 0;
      int debito = 0;
      int credito = 0;
      int pix = 0;
      int boleto = 0;
      int transferencia = 0;
      int cheque = 0;
      int valeAlimentacao = 0;
      int valeRefeicao = 0;
      int carteiraDigital = 0;

      for (var doc in snapshot2.docs) {
        switch (doc.get('formaPagamento')) {
          case 'dinheiro':
            dinheiro++;
            break;
          case 'debito':
            debito++;
            break;
          case 'credito':
            credito++;
            break;
          case 'pix':
            pix++;
            break;
          case 'boleto':
            boleto++;
            break;
          case 'transferencia':
            transferencia++;
            break;
          case 'cheque':
            cheque++;
            break;
          case 'valeAlimentação':
            valeAlimentacao++;
            break;
          case 'valeRefeicao':
            valeRefeicao++;
            break;
          case 'carteiraDigital':
            carteiraDigital++;
            break;
        }
      }
      dashboardController.listPaymentsTypeData.clear();

      if (dinheiro > 0) {
        dashboardController.listPaymentsTypeData.add(
          PaymentsTypeData('Dinheiro', dinheiro),
        );
      }
      if (debito > 0) {
        dashboardController.listPaymentsTypeData.add(
          PaymentsTypeData('Débito', debito),
        );
      }
      if (credito > 0) {
        dashboardController.listPaymentsTypeData.add(
          PaymentsTypeData('Crédito', credito),
        );
      }
      if (pix > 0) {
        dashboardController.listPaymentsTypeData.add(
          PaymentsTypeData('PIX', pix),
        );
      }
      if (boleto > 0) {
        dashboardController.listPaymentsTypeData.add(
          PaymentsTypeData('Boleto', boleto),
        );
      }
      if (transferencia > 0) {
        dashboardController.listPaymentsTypeData.add(
          PaymentsTypeData('Transferência', transferencia),
        );
      }
      if (cheque > 0) {
        dashboardController.listPaymentsTypeData.add(
          PaymentsTypeData('Cheque', cheque),
        );
      }
      if (valeAlimentacao > 0) {
        dashboardController.listPaymentsTypeData.add(
          PaymentsTypeData('Vale Alimentação', valeAlimentacao),
        );
      }
      if (valeRefeicao > 0) {
        dashboardController.listPaymentsTypeData.add(
          PaymentsTypeData('Vale Refeição', valeRefeicao),
        );
      }
      if (carteiraDigital > 0) {
        dashboardController.listPaymentsTypeData.add(
          PaymentsTypeData('Carteira Digital', carteiraDigital),
        );
      }
    } catch (e) {
      e.printError();
    }
  }

  Future<void> paymentsReceivedInLastSixMonths() async {
    try {
      final user = Get.find<UserController>();
      final dashboardController = Get.find<DashboardPageController>();
      final now = DateTime.now().toUtc();
      dashboardController.listPaymentsData.clear();
      for (int i = 5; i != -1; i--) {
        final startDate = DateTime.utc(now.year, now.month - i, 1);
        final endDate = DateTime.utc(now.year, now.month - i + 1, 1);
        final snapshot2 = await db
            .collection('usuarios/${user.loggedUser.id}/payments')
            .where(
              'dataPagamento',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
            )
            .where('dataPagamento', isLessThan: Timestamp.fromDate(endDate))
            .get();

        int totalAmount = snapshot2.size;
        if (totalAmount == 0) {
          continue;
        }
        dashboardController.listPaymentsData.add(
          PaymentsData(
            dashboardController.getMonthNamePtBr(startDate.month - 1),
            totalAmount,
          ),
        );
      }
    } catch (e) {
      e.printError();
    }
  }
}
