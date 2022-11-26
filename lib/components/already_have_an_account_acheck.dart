import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/strings/colors_proj.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final press;
  const AlreadyHaveAnAccountCheck({
    Key? key, 
    this.login = true, 
    required this.press, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      Text(
        login ? "Dont't have an Account ? " : "Already Have An Account ? ", 
        style: TextStyle(color: KPrimaryColor),
      ),
      GestureDetector(
        onTap: press,
        child: Text(
          login ? "Sign Up" : "Sign In", 
          style: TextStyle(
            color: KPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
        ],
    );
  }
}