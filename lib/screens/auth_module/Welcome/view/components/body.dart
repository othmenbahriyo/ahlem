import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/rounded_button.dart';
import 'package:flutter_application_1/constant/strings/colors_proj.dart';
import 'package:flutter_application_1/screens/auth_module/Login/view/components/background.dart';
import 'package:flutter_application_1/screens/auth_module/Login/view/login_screens.dart';
import 'package:flutter_application_1/screens/auth_module/Signup/view/signup_screen.dart';
import 'package:flutter_svg/svg.dart';

class BodyC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    var roundedButton = RoundedButton;
    var kPrimaryLightColor;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.1),
            const Text(
              "WELCOME",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.37,
            ),
            SizedBox(height: size.height * 0.05),
            SizedBox(
              height: 70,
              child: RoundedButton(
                text: "LOGIN",
                fontsize: 17 ,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 70,
              child: RoundedButton(
                text: "SIGN UP",
                fontsize: 17 ,
                color: KPrimaryLightColor,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
