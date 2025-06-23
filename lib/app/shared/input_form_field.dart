import 'package:aluga_facil/app/themes/app_colors.dart';
import 'package:flutter/material.dart';

TextFormField inputText (
  String key,
  String title,
  IconData iconImage, {
  bool isPassword = false,
  TextEditingController? textController,
}) {
  return TextFormField(
    key: Key(key),
    controller: textController,
    style: const TextStyle(color: goldColorThree, fontFamily: 'Raleway'),
    autocorrect: false,
    keyboardType: TextInputType.emailAddress,
    obscureText: isPassword,
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
          ? IconButton(
              onPressed: () {},
              icon: Icon(Icons.visibility_off, color: goldColorThree),
            )
          : null,
    ),
  );
}
