import 'package:aluga_facil/app/controllers/house_controller.dart';
import 'package:aluga_facil/app/controllers/user_controller.dart';
import 'package:aluga_facil/app/data/databases/db_firestore.dart';
import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class HouseProvider {
  late FirebaseFirestore db;

  HouseProvider() {
    _startProvider();
  }

  _startProvider() {
    _startFireStore();
  }

  _startFireStore() {
    db = DbFirestore.get();
  }

  // saveAll(List<HouseModel> lista) {
  //   final user = Get.find<UserController>();
  //   final houseController = Get.find<HouseController>();
  //   lista.forEach((casa) async {
  //     if (!lista.any((atual) => atual.numeroCasa == casa.numeroCasa)) {
  //       houseController.lista.add(casa);
  //       await db
  //           .collection('usuarios/${user.loggedUser.id}/imoveis')
  //           .doc(casa.numeroCasa.toString())
  //           .set({
  //             'numeroCasa': casa.numeroCasa,
  //             'logradouro': casa.logradouro,
  //             'fotoCasa': casa.fotoCasa,
  //             'valorAluguel': casa.valorAluguel,
  //             'dataAluguel': casa.dataAluguel,
  //             'inquilino': casa.inquilino,
  //           });
  //     }
  //   });
  // }

  Future<void> save(HouseModel casa) async {
    final user = Get.find<UserController>();
    final houseController = Get.find<HouseController>();
    houseController.lista.add(casa);
    await db
        .collection('usuarios/${user.loggedUser.id}/imoveis')
        .doc(casa.id.toString())
        .set({
          'id': casa.id,
          'numeroCasa': casa.numeroCasa,
          'logradouro': casa.logradouro,
          'bairro': casa.bairro,
          'cidade': casa.cidade,
          'fotoCasa': casa.fotoCasa,
          'valorAluguel': casa.valorAluguel,
          'dataAluguel': casa.dataAluguel,
          'inquilino': casa.inquilino,
        });
  }

  Future<void> readCasas() async {
    try {
      final user = Get.find<UserController>();
      final houseController = Get.find<HouseController>();
      houseController.isLoading.value = true;
      houseController.lista.clear();
      final snapshot = await db
          .collection('usuarios/${user.loggedUser.id}/imoveis')
          .get();

      snapshot.docs.forEach((doc) {
        HouseModel casa = HouseModel(
          dataAluguel: doc.get('dataAluguel'),
          fotoCasa: doc.get('fotoCasa'),
          inquilino: doc.get('inquilino'),
          logradouro: doc.get('logradouro'),
          cidade: doc.get('bairro'),
          bairro: doc.get('cidade'),
          id: doc.get('id'),
          numeroCasa: doc.get('numeroCasa'),
          valorAluguel: doc.get('valorAluguel'),
        );
        houseController.lista.add(casa);
      });
      houseController.isLoading.value = false;
    } catch (e) {
      //showMessageBar('Erro!', e.toString());
      e.printError();
    }
  }

  Future<void> remove(HouseModel casa) async {
    final user = Get.find<UserController>();
    await db
        .collection('usuarios/${user.loggedUser.id}/imoveis')
        .doc(casa.id.toString())
        .delete();
    final houseController = Get.find<HouseController>();
    houseController.lista.remove(casa);
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
