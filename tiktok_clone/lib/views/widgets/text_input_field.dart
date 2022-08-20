import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final IconData icon;
  final String lable;
  final bool isObscure;
  const TextInputField(
      {Key? key,
      required this.textEditingController,
      required this.icon,
      required this.lable,
      this.isObscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        label: Text(lable),
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle(fontSize: 18, color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 2.0,
          ),
        ),
      ),
      obscureText: isObscure,
    );
  }
}
