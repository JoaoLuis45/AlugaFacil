import 'package:aluga_facil/app/controllers/house_controller.dart';
import 'package:aluga_facil/app/controllers/inquilino_page_controller.dart';
import 'package:aluga_facil/app/controllers/user_controller.dart';
import 'package:aluga_facil/app/data/databases/db_firestore.dart';
import 'package:aluga_facil/app/data/models/inquilino_model.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    final houseController = Get.find<HouseController>();
    houseController.lista.add(inquilino);
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
          'valorAluguel': inquilino.casaNumero,
          'dataAluguel': inquilino.casaId,
        });
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
          dataNascimento:  doc.get('dataNascimento') != null
              ? DateTime.parse(doc.get('dataNascimento'))
              : null,
          casaNumero:  doc.get('casaNumero'),
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
    final user = Get.find<UserController>();
    await db
        .collection('usuarios/${user.loggedUser.id}/inquilinos')
        .doc(inquilino.cpf.toString())
        .delete();
    final houseController = Get.find<HouseController>();
    houseController.lista.remove(inquilino);
  }
}

showMessageBar(title, subtitle) {
  Get.snackbar(
    title,
    subtitle,
    backgroundColor: brownColorTwo,
    colorText: goldColorThree,
    duration: const Duration(seconds: 6),
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(10),
  );
}
