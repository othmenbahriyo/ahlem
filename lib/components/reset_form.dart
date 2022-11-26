import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/strings/colors_proj.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ResetForm extends StatelessWidget {
  final _emailController = TextEditingController();
  bool validate = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: _emailController,

        decoration: const InputDecoration(
          hintText: "Email", hintStyle: TextStyle(color: kTextFieldColor),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: KPrimaryColor))
        
        ),
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        //validator: (email) =>
             //email !=null && !EmailValidator.validate(email)
                   //? 'Enter a valid email'
                   //: null,
      ),
    );
  }
}