import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/already_have_an_account_acheck.dart';
import 'package:flutter_application_1/components/reset_password.dart';
import 'package:flutter_application_1/components/rounded_button.dart';
import 'package:flutter_application_1/components/rounded_input_field.dart';
import 'package:flutter_application_1/components/rounded_password_field.dart';
import 'package:flutter_application_1/constant/strings/colors_proj.dart';
import 'package:flutter_application_1/screens/auth_module/Login/view/components/background.dart';
import 'package:flutter_application_1/screens/auth_module/Login/view/login_screens.dart';
import 'package:flutter_application_1/screens/auth_module/Signup/view/components/social_icon.dart';
import 'package:flutter_application_1/screens/auth_module/resetpassword/reset_password_view.dart';
import 'package:flutter_svg/svg.dart';




class BodyA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    var roundedPasswordField = RoundedPasswordField;
    return Background(
     child: SingleChildScrollView(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.1),

          const Text(
            "SIGNUP", 
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),
          ),
          SizedBox(height: size.height * 0.03),
          SvgPicture.asset(
            "assets/icons/signup.svg",
            height: size.height * 0.35,
          ),
          RoundedInputField(
            hintText: "Your Email",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            onChanged: (value) {},
          ),
         /* RoundedButton(
            text: "SIGNUP",
            press: () {},
          ),*/
          SizedBox(
            height: 70,
            child: RoundedButton(
              text: "Sign Up",
              onPressed: () async {


                /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DeclarerObjetScreen();
                          },
                        ),
                      );
                       var res = await UserService().save(email: email, password: password);
                       print("***********");
                       if (res.statusCode == 200) {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) {
                               return DeclarerObjetScreen();
                             },
                           ),
                         );
                       }
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));*/
              },
            ),
          ),

          SizedBox(height: size.height * 0.03),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                  
                ),
              );
            }, 
          ),
          //OrDivider(),
          //Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            //children: <Widget>[
              //SocalInput(
                //iconSrc: "assets/icons/facebook.svg",
                //press: () {},
              //),
              //SocalInput(
                //iconSrc: "assets/icons/twitter.svg",
                //press: () {},
              //),
              //SocalInput(
                //iconSrc: "assets/icons/google-plus.svg",
                //press: () {},
              //),
            //],
          //)
        ],
       ),
     )
    );
  }
}