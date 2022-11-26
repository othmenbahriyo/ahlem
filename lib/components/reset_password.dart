
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/reset_form.dart';
import 'package:flutter_application_1/components/rounded_button.dart';
import 'package:flutter_application_1/screens/auth_module/Login/view/login_screens.dart';
import 'package:form_field_validator/form_field_validator.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);


  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool validate = false;
  //final Storage = new FlutterSecureStorage();
  final _emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();  
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  //Future ResetPassword() async {
   // showDialog(
    //  context: context, 
    //  barrierDismissible: false,
     // builder: (context) => Center(child: CircularProgressIndicator()),
    //);
    //try {
     //     await strapi.services.instance.sendResetPasswordEmail(email: _emailController.text.trim());
      //    Utils.showSnackBar('Password Reset Email Sent');
       //   Navigator.of(context).popUntil((route) => route.isFirst);
      
    //} on strapiException catch (e) {
     // print(e);
      
          
     // Utils.showSnackBar(e.message);
     // Navigator.of(context).pop();
    //}
  //}
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 250,
            ),
            const Text(
              "Reset Password",
              style: TextStyle(),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Please enter your email address and we will send you a password reset link ", 
            style: const TextStyle(),

            ),
            const SizedBox(
              height: 10,
            ),
            ResetForm(),
            const SizedBox(height: 40,),
            GestureDetector(
              onTap: () async {
            


  

                   
                
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: const RoundedButton(text: ('Reset')),
                
            ),
          ],
        ),
      ),
      
    );
  }
}