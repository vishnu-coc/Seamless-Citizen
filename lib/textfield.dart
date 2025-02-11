import 'package:flutter/material.dart';

class TextfieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool ispass;
  final String hintText;
  final IconData icon;

  const TextfieldInput({
    super.key,
    required this.textEditingController,
    this.ispass = false,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        obscureText: ispass,
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black, fontSize: 18),
            prefixIcon: Icon(icon),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[300],
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}
