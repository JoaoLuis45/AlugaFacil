import 'package:aluga_facil/app/Exceptions/invalid_date_aluguel.dart';
import 'package:aluga_facil/app/controllers/dashboard_page_controller.dart';
import 'package:aluga_facil/app/controllers/house_controller.dart';
import 'package:aluga_facil/app/controllers/user_controller.dart';
import 'package:aluga_facil/app/data/databases/db_firestore.dart';
import 'package:aluga_facil/app/data/models/house_model.dart';
import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/utils/mask_formatters.dart';
import 'package:aluga_facil/app/utils/normal_date.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  Future<void> update(HouseModel casa) async {
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
        }, SetOptions(merge: true));
  }

  Future<HouseModel?> getCasa(String casaId) async {
    try {
      final user = Get.find<UserController>();
      final snapshot = await db
          .collection('usuarios/${user.loggedUser.id}/imoveis')
          .where('id', isEqualTo: casaId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        return HouseModel(
          dataAluguel: (doc.get('dataAluguel') as Timestamp?)?.toDate(),
          fotoCasa: doc.get('fotoCasa'),
          inquilino: doc.get('inquilino'),
          logradouro: doc.get('logradouro'),
          cidade: doc.get('bairro'),
          bairro: doc.get('cidade'),
          id: doc.get('id'),
          numeroCasa: doc.get('numeroCasa'),
          valorAluguel: doc.get('valorAluguel'),
        );
      } else {
        return null;
      }
    } catch (e) {
      e.printError();
    }
    return null;
  }

  Future<dynamic> setInquilino(HouseModel casa) async {
    final user = Get.find<UserController>();
    DateTime? dataAluguel = await selectDataAluguel();
    if (dataAluguel == null) {
      return Future.error(InvalidDateAluguel());
    }
    casa.dataAluguel = dataAluguel;
    await db
        .collection('usuarios/${user.loggedUser.id}/imoveis')
        .doc(casa.id.toString())
        .update({'inquilino': casa.inquilino, 'dataAluguel': casa.dataAluguel});
    await read();
  }

  Future<void> unsetInquilino(String casaId) async {
    final user = Get.find<UserController>();
    await db
        .collection('usuarios/${user.loggedUser.id}/imoveis')
        .doc(casaId)
        .update({'inquilino': null, 'dataAluguel': null});
    await read();
  }

  Future<void> read() async {
    try {
      final user = Get.find<UserController>();
      final houseController = Get.find<HouseController>();
      List casas = [];
      houseController.isLoading.value = true;
      houseController.lista.clear();
      final snapshot = await db
          .collection('usuarios/${user.loggedUser.id}/imoveis')
          .get();

      for (var doc in snapshot.docs) {
        HouseModel casa = HouseModel(
          dataAluguel: (doc.get('dataAluguel') as Timestamp?)?.toDate(),
          fotoCasa: doc.get('fotoCasa'),
          inquilino: doc.get('inquilino'),
          logradouro: doc.get('logradouro'),
          cidade: doc.get('bairro'),
          bairro: doc.get('cidade'),
          id: doc.get('id'),
          numeroCasa: doc.get('numeroCasa'),
          valorAluguel: doc.get('valorAluguel'),
        );
        casas.add(casa);
      }
      houseController.lista.assignAll(casas);
      houseController.isLoading.value = false;
    } catch (e) {
      //showMessageBar('Erro!', e.toString());
      e.printError();
    }
  }

  Future<void> search(String search) async {
    try {
      final user = Get.find<UserController>();
      final houseController = Get.find<HouseController>();
      houseController.isLoading.value = true;
      houseController.lista.clear();
      final snapshot = await db
          .collection('usuarios/${user.loggedUser.id}/imoveis')
          .where('numeroCasa', isGreaterThanOrEqualTo: search)
          .where('numeroCasa', isLessThanOrEqualTo: '$search\uf8ff')
          .get();

      for (var doc in snapshot.docs) {
        HouseModel casa = HouseModel(
          dataAluguel: (doc.get('dataAluguel') as Timestamp?)?.toDate(),
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
      }
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

  Future<DateTime?> selectDataAluguel() async {
    TextEditingController controller = TextEditingController();
    DateTime? dataAluguel;
    await showModalBottomSheet(
      backgroundColor: brownColorTwo,
      context: Get.context!,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: brownColorTwo,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              topLeft: Radius.circular(50),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                child: Text(
                  'Selecione a data do aluguel',
                  style: TextStyle(fontSize: 22, color: goldColorThree),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                child: TextFormField(
                  controller: controller,
                  inputFormatters: [maskFormatterDate],
                  onTap: () async {
                    List<DateTime?>? results =
                        await showCalendarDatePicker2Dialog(
                          context: context,
                          config: CalendarDatePicker2WithActionButtonsConfig(),
                          dialogSize: const Size(325, 400),
                          value: [DateTime.now()],
                          borderRadius: BorderRadius.circular(15),
                        );
                    if (results != null && results.isNotEmpty) {
                      controller.text = formatDate(results.first);
                      dataAluguel = results.first;
                      Get.back();
                    }
                  },
                  readOnly: true,
                  style: const TextStyle(
                    color: goldColorTwo,
                    fontFamily: 'Raleway',
                  ),
                  decoration: InputDecoration(
                    fillColor: brownColorTwo,
                    filled: true,
                    labelText: 'Data do aluguel',
                    labelStyle: TextStyle(color: goldColorTwo),
                    prefixIcon: Icon(Icons.today_outlined, color: goldColorTwo),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: goldColorTwo, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: goldColorTwo, width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    return dataAluguel;
  }

  Future<void> getSituationHouses() async {
    try {
      final user = Get.find<UserController>();
      final dashboardController = Get.find<DashboardPageController>();
      final snapshot = await db
          .collection('usuarios/${user.loggedUser.id}/imoveis')
          .get();
      int totalAvailable = 0;
      for (var doc in snapshot.docs) {
        if (doc.get('inquilino') == null) {
          totalAvailable++;
        }
      }
      dashboardController.totalHousesAvailable.value = totalAvailable;
      dashboardController.totalHousesRented.value =
          snapshot.size - totalAvailable;
    } catch (e) {
      e.printError();
    }
  }
}
