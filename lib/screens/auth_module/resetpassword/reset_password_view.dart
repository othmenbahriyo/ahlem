import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth_module/Login/view/login_screens.dart';
import 'package:flutter_application_1/screens/auth_module/resetpassword/reset_password_controller.dart';

import 'package:get/get.dart';



/// used to do validation when button is pressed and to focus the TextFormField when the transition to the screen.
final formKey2 = GlobalKey<FormState>();

class ResetPasswordView extends GetView<ResetPasswordController> {
   const ResetPasswordView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final resetPasswordController = Get.put(ResetPasswordController());

    bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding:const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: SingleChildScrollView(
            controller: ScrollController(),

            key: Key('resetpw'),
            reverse: false,
            child:Form(
              key: formKey2,
              child: Column(
                children: <Widget>[
                  keyboardOpen ? const SizedBox(height: 0) :  const SizedBox(height: 80.0),
                  // Obx((){ return controller.onSuccess.value ? buildCheckLogo() : buildSmallLogo(keyboardOpen);}),
                  keyboardOpen ? const SizedBox(height: 5) :  const SizedBox(height: 10.0),
                  // Obx((){ return controller.onSuccess.value
                  //     ? buildFixedTitle('Success'.tr,'Your password has been successfully'.tr,'changed'.tr)
                  //     : buildChangedTitle(keyboardOpen,'Reset Password'.tr,'Enter your new password'.tr);}),
                  keyboardOpen ? const SizedBox(height: 5) :  const SizedBox(height: 50.0),
                  // Obx((){ return controller.onSuccess.value
                  //     ? Container(height: 70,)
                  //     : buildPasswordField(
                  //     keyboardOpen,
                  //     controller.passwordController,
                  //     controller.onIconPressed,
                  //     (value) {
                  //       RegExp regex = RegExp(r'^.{6,}$');
                  //       if (value!.isEmpty) {
                  //         return ("Password is required".tr);
                  //       }
                  //       if (!regex.hasMatch(value)) {
                  //         return ("Enter Valid Password(Min. 6 Character)".tr);
                  //       }},
                  //     'New Password'.tr ,
                  //     "Enter your password...".tr);}),
                  keyboardOpen ? const SizedBox(height: 5) :  const SizedBox(height: 15.0),
                  // Obx((){ return controller.onSuccess.value
                  //     ? Container()
                  //     : buildPasswordField(
                  //     keyboardOpen,
                  //     controller.confirmPasswordController,
                  //     controller.onConfirmPressed,
                  //         (value) {
                  //       RegExp regex = RegExp(r'^.{6,}$');
                  //       if (value!.isEmpty) {
                  //         return ("Confirm Password is required".tr);
                  //       }
                  //       if (!regex.hasMatch(value)) {
                  //         return ("Enter Valid Password(Min. 6 Character)".tr);
                  //       }
                  //       if (resetPasswordController.passwordController.text != value) {
                  //         return ("Error Passwords are not matching!".tr);
                  //       }
                  //     },
                  //     'Confirm New Password'.tr ,
                  //     "Enter your password...".tr);}),
                  // keyboardOpen ? buildFlatButton() : Container(),
                  // keyboardOpen ? const SizedBox(height: 0) :  const SizedBox(height: 120.0),
                  // Obx((){
                  //   return controller.onSuccess.value
                  //       ? buildButton("Login".tr, (){
                  //           Get.off(()=> LoginScreen(),binding: LoginBinding());
                  //          })
                  //       : buildElevatedButton('Reset Password'.tr, controller.isLoading,(){
                  //     FocusScope.of(context).unfocus(); /// to dismiss the keyboard
                  //       if (formKey2.currentState!.validate()) {
                  //         controller.isLoading.value = true;
                  //         controller.resetPassword();
                  //       }
                  //   });
                  // }),
                  keyboardOpen ? const SizedBox(height: 0) :  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

