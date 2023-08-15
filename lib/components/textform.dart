import 'package:flutter/material.dart';

class MyTextFormFields extends StatelessWidget {
  final keyboard_type;
  bool hide_text;
  TextEditingController FormController = TextEditingController();
  final String hint_text;
  final Icon Prefix_Icon;
  final String condation;
  final String retunt_text;
  final int MaxLines;

  MyTextFormFields({
    Key? key,
    this.keyboard_type = TextInputType.emailAddress,
    this.hide_text = false,
    required this.FormController,
    required this.hint_text,
    required this.Prefix_Icon,
    required this.condation,
    required this.retunt_text,
    this.MaxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: MaxLines,
      keyboardType: keyboard_type,
      obscureText: hide_text,
      controller: FormController,
      decoration: InputDecoration(
        hintText: hint_text,
        prefixIcon: Prefix_Icon,
      ),
      validator: (value) {
        if (FormController == null || FormController.text.isEmpty) {
          return 'Enter $hint_text';
        } else if (!FormController.text.contains(condation) ||
            FormController.text.length < 6) {
          return retunt_text;
        }
      },
    );
  }
}
