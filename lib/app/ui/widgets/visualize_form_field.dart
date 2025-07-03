import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VisualizeTextFormField extends StatelessWidget {
  final TextEditingController textController;
  final String keyy;
  final IconData iconImage;
  final String title;

  const VisualizeTextFormField({
    super.key,
    required this.textController,
    required this.keyy,
    required this.iconImage,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(color: goldColorTwo),
        prefixIcon: Icon(iconImage, color: goldColorTwo),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: brownColorOne, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: goldColorThree, width: 2),
        ),
      ),
    );
  }
}
