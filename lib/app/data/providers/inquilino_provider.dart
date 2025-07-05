import 'package:aluga_facil/app/controllers/inquilino_page_controller.dart';
import 'package:aluga_facil/app/controllers/user_controller.dart';
import 'package:aluga_facil/app/data/databases/db_firestore.dart';
import 'package:aluga_facil/app/data/models/inquilino_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';

class InquilinoProvider {
  late FirebaseFirestore db;

  InquilinoProvider() {
    _startProvider();
  }

  _startProvider() {
    _startFireStore();
  }

  _startFireStore() {
    db = DbFirestore.get();
  }

  Future<void> save(InquilinoModel inquilino) async {
    final user = Get.find<UserController>();
    final inquilinoController = Get.find<InquilinoPageController>();
    inquilinoController.lista.add(inquilino);
    await db
        .collection('usuarios/${user.loggedUser.id}/inquilinos')
        .doc(inquilino.cpf.toString())
        .set({
          'cpf': inquilino.cpf,
          'celular': inquilino.celular,
          'dataNascimento': inquilino.dataNascimento,
          'email': inquilino.email,
          'nome': inquilino.nome,
          'telefone': inquilino.telefone,
          'casaNumero': inquilino.casaNumero,
          'casaId': inquilino.casaId,
        });
  }

  Future<void> update(InquilinoModel inquilino) async {
    final user = Get.find<UserController>();
    final inquilinoController = Get.find<InquilinoPageController>();
    inquilinoController.lista.add(inquilino);
    await db
        .collection('usuarios/${user.loggedUser.id}/inquilinos')
        .doc(inquilino.cpf.toString())
        .set({
          'cpf': inquilino.cpf,
          'celular': inquilino.celular,
          'dataNascimento': inquilino.dataNascimento,
          'email': inquilino.email,
          'nome': inquilino.nome,
          'telefone': inquilino.telefone,
          'casaNumero': inquilino.casaNumero,
          'casaId': inquilino.casaId,
        }, SetOptions(merge: true));
  }

  Future<void> setCasa(InquilinoModel inquilino) async {
    final user = Get.find<UserController>();
    await db
        .collection('usuarios/${user.loggedUser.id}/inquilinos')
        .doc(inquilino.cpf.toString())
        .update({
          'casaNumero': inquilino.casaNumero,
          'casaId': inquilino.casaId,
        });
    await read();
  }

  Future<void> unsetCasa(InquilinoModel inquilino) async {
    final user = Get.find<UserController>();
    await db
        .collection('usuarios/${user.loggedUser.id}/inquilinos')
        .doc(inquilino.cpf.toString())
        .update({'casaNumero': null, 'casaId': null});
    await read();
  }

  Future<void> read() async {
    try {
      final user = Get.find<UserController>();
      final inquilinoController = Get.find<InquilinoPageController>();
      inquilinoController.isLoading.value = true;
      inquilinoController.lista.clear();
      final snapshot = await db
          .collection('usuarios/${user.loggedUser.id}/inquilinos')
          .get();
      snapshot.docs.forEach((doc) {
        InquilinoModel inquilino = InquilinoModel(
          nome: doc.get('nome'),
          casaId: doc.get('casaId'),
          email: doc.get('email'),
          cpf: doc.get('cpf'),
          telefone: doc.get('telefone'),
          celular: doc.get('celular'),
          dataNascimento: (doc.get('dataNascimento') as Timestamp).toDate(),
          casaNumero: doc.get('casaNumero'),
        );
        inquilinoController.lista.add(inquilino);
      });
      inquilinoController.isLoading.value = false;
    } catch (e) {
      //showMessageBar('Erro!', e.toString());
      e.printError();
    }
  }

  Future<InquilinoModel?> getInquilino(String cpf) async {
    try {
      final user = Get.find<UserController>();
      final snapshot = await db
          .collection('usuarios/${user.loggedUser.id}/inquilinos')
          .where('cpf', isEqualTo: cpf)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        return InquilinoModel(
          nome: doc.get('nome'),
          casaId: doc.get('casaId'),
          email: doc.get('email'),
          cpf: doc.get('cpf'),
          telefone: doc.get('telefone'),
          celular: doc.get('celular'),
          dataNascimento: (doc.get('dataNascimento') as Timestamp).toDate(),
          casaNumero: doc.get('casaNumero'),
        );
      }else{
        return null;
      }
      
    } catch (e) {
      //showMessageBar('Erro!', e.toString());
      e.printError();
    }
    return null;
  }

  Future<void> search(String search) async {
    try {
      final user = Get.find<UserController>();
      final inquilinoController = Get.find<InquilinoPageController>();
      inquilinoController.isLoading.value = true;
      inquilinoController.lista.clear();
      final snapshot = await db
          .collection('usuarios/${user.loggedUser.id}/inquilinos')
          .where('nome', isGreaterThanOrEqualTo: search).where('nome', isLessThanOrEqualTo: search + '\uf8ff').get();
      snapshot.docs.forEach((doc) {
         InquilinoModel inquilino = InquilinoModel(
          nome: doc.get('nome'),
          casaId: doc.get('casaId'),
          email: doc.get('email'),
          cpf: doc.get('cpf'),
          telefone: doc.get('telefone'),
          celular: doc.get('celular'),
          dataNascimento: (doc.get('dataNascimento') as Timestamp).toDate(),
          casaNumero: doc.get('casaNumero'),
        );
        inquilinoController.lista.add(inquilino);
      });
      inquilinoController.isLoading.value = false;
    } catch (e) {
      //showMessageBar('Erro!', e.toString());
      e.printError();
    }
  }

  Future<void> remove(InquilinoModel inquilino) async {
    final inquilinoController = Get.find<InquilinoPageController>();
    final user = Get.find<UserController>();
    await db
        .collection('usuarios/${user.loggedUser.id}/inquilinos')
        .doc(inquilino.cpf.toString())
        .delete();
    inquilinoController.lista.remove(inquilino);
  }
}
