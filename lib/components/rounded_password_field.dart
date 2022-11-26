import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_field_container.dart';
import 'package:flutter_application_1/constant/strings/colors_proj.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
   RoundedPasswordField({
     this.onChanged,
     this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              onChanged: onChanged,
              validator: validator,
              decoration: const InputDecoration(
                hintText: "Password",
                icon: Icon(
                  Icons.lock,
                  color: KPrimaryColor,
                ),
                suffixIcon: Icon(
                  Icons.visibility, 
                  color: KPrimaryColor,
                ),
                border: InputBorder.none,
              ),
            ),
          
          
    );
  }
}

      
   
