import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

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