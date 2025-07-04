import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> showDialogMessage(BuildContext context,String titulo,String message) async {
  var result;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: brownColorTwo,
        title: Text(titulo, style: const TextStyle(color: goldColorThree)),
        content: Text(
          message,
          style: TextStyle(color: goldColorThree),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: goldColorThree),
            child: const Text('NÃO', style: TextStyle(color: brownColorTwo)),
            onPressed: () {
              result = false;
              Get.back();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: goldColorThree),
            child: const Text('SIM', style: TextStyle(color: brownColorTwo)),
            onPressed: () {
              result = true;
              Get.back();
            },
          ),
        ],
      );
    },
  );
  return result;
}
