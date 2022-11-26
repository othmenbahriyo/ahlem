import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_field_container.dart';
import 'package:flutter_application_1/constant/strings/colors_proj.dart';


class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final TextInputType? keyboard;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const RoundedInputField({
    Key? key, 
    this.hintText, 
    this.keyboard = TextInputType.text,
    this.validator,
    this.icon = Icons.person, 
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var kPrimaryColor;
    return TextFieldContainer(
      child: TextFormField(
        onChanged: onChanged,
        keyboardType:keyboard  ,
        cursorColor: kPrimaryColor,
        validator: validator,
        decoration: InputDecoration(
          icon: Icon(
            Icons.person,
            color: KPrimaryColor,
          ),
          hintText: "Email",
          border: InputBorder.none,
      ),
    ));
  }
}

