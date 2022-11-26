import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/already_have_an_account_acheck.dart';
import 'package:flutter_application_1/components/declarer_objet.dart';
import 'package:flutter_application_1/components/rounded_button.dart';
import 'package:flutter_application_1/components/rounded_input_field.dart';
import 'package:flutter_application_1/components/rounded_password_field.dart';
import 'package:flutter_application_1/constant/strings/colors_proj.dart';
import 'package:flutter_application_1/screens/auth_module/Login/view/components/background.dart';
import 'package:flutter_application_1/screens/auth_module/Signup/view/signup_screen.dart';
import 'package:flutter_application_1/screens/home/home_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';

class BodyB extends StatelessWidget {
  var email = "";
  var password = "";
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String validatepass(value){
     if(value.isEmpty){
       return "Required";
        }else if(value.length < 6){
          return "Should Be At Least 6 characters";
        }else if(value.length > 15){
          return "Should Be At More Than 15 characters";
        }else{
          return '';
        }
     }
            
  void validahsgted(){
    if(formkey.currentState!.validate()){
      print("Validated");
    }else{
      print("Not Validated");
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
      child: Form(
          key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.1),
            const Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.3,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              //color: Colors.KPrimaryColor;
              hintText: "Your Email",
              keyboard: TextInputType.emailAddress,
              validator: EmailValidator(errorText: 'enter a valid email address'),
             // color: Colors.KPrimaryColor;

              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              validator: validatepass,

              onChanged: (value) {
                password = value;
              },
            ),
            Column(
              children: [
                SizedBox(
                  height: 70,
                  child: RoundedButton(
                    text: "LOGIN",
                    onPressed: () async {
                      if(!formkey.currentState!.validate()){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeScreen(
                                description: "",
                                details: "",
                                etat: "",
                                imageUrl: "",
                                localisation: "",
                                nombre: "",
                                temps: "",

                              );
                            },
                          ),
                        );
                      }

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
              ],
            ),
            SizedBox(height: size.height * 0.03),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(description: "",
                              details: "",
                              etat: "",
                              imageUrl: "",
                              localisation: "",
                              nombre: "",
                              temps: "",
                              ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
