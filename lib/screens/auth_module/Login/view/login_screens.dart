import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/add_hashtag_component.dart';
import 'package:flutter_application_1/components/inscription_perdu.dart';
import 'package:flutter_application_1/components/rounded_input_field.dart';
import 'package:flutter_application_1/components/rounded_password_field.dart';
import 'package:flutter_application_1/screens/auth_module/Login/view/components/body.dart';
import 'package:flutter_application_1/screens/home/home_screen.dart';
import 'package:flutter_application_1/screens/views/list_hashtag_view.dart';
import 'package:http/http.dart' as http;
    
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyB(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    RoundedInputFieldEmail,
    RoundedPasswordFieldPassword,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    var roundedPasswordField = RoundedPasswordField;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.35,
            ),
          ),
          const RoundedInputField(),
          RoundedPasswordField(),
        ],
      ),
    );
  }
}

      