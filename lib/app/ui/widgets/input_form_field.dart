import 'package:aluga_facil/app/ui/themes/app_colors.dart';
import 'package:aluga_facil/app/ui/widgets/controllers/input_form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

// ignore: must_be_immutable
class InputTextFormField extends StatelessWidget {
  final TextEditingController textController;
  final bool isPassword;
  final String keyy;
  final String title;
  final IconData iconImage;
  final InputFormFieldController controller;

  const InputTextFormField({
    super.key,
    required this.textController,
    required this.isPassword,
    required this.keyy,
    required this.title,
    required this.iconImage,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextFormField(
        key: Key(keyy),
        controller: textController,
        style: const TextStyle(color: goldColorThree, fontFamily: 'Raleway'),
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        obscureText: isPassword ? !controller.isVisible : controller.isVisible,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
          ),
          filled: true,
          fillColor: goldToBrownColor,
          hintText: title,
          hintStyle: const TextStyle(fontSize: 18, color: goldColorThree),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(top: 9, bottom: 9),
            child: Icon(
              iconImage,
              color: goldColorThree,
            ), // myIcon is a 48px-wide widget.
          ),
          suffixIcon: isPassword
              ? controller.isVisible
                    ? IconButton(
                        onPressed: () {
                          controller.isVisible = false;
                        },
                        icon: Icon(Icons.visibility, color: goldColorThree),
                      )
                    : IconButton(
                        onPressed: () {
                          controller.isVisible = true;
                        },
                        icon: Icon(Icons.visibility_off, color: goldColorThree),
                      )
              : null,
        ),
      );
    });
  }
}
