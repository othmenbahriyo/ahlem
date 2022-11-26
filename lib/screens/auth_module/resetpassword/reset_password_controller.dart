import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth_module/resetpassword/data.dart';
import 'package:get/get.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import 'dart:developer' as dev;



class ResetPasswordController extends GetxController {

  /// used to create an instance of the TextEditingController
  final TextEditingController passwordController =  TextEditingController();
  final TextEditingController confirmPasswordController =  TextEditingController();
 // final verificationCodeController = Get.put(verificationCodeController());


  /// used in the password field to change the visibility icon (true => Icons.visibility_off) (false => Icons.visibility)
  var onIconPressed = true.obs ;

  /// used in the confirm password field to change the visibility icon (true => Icons.visibility_off) (false => Icons.visibility)
  var onConfirmPressed = true.obs ;

  /// used to change our obx widgets (true => show success components)
  var onSuccess = false.obs;

  /// Variable to get the pinput
  var pinValue = Get.arguments ;

  /// used to change the icon of the login button (false => button without loading icon) (true => button with loading icon)
  var isLoading = false.obs;





  /// Create an instance of ResetPasswordService to get the data of the service
  resetPassword() async {
    await ResetPasswordService.getInstance()?.resetPassword(
        code: pinValue,
        password: passwordController.text,

        onSuccess: (response) async {
          if (response == null) {
            Get.snackbar('Error', 'This mail is not found !');
            dev.log('error');
          } else {
            isLoading.value = false;
            onSuccess.value = true;
          }
        }, onError: (e) {
      Get.snackbar('Error', 'This mail is not found !');
      dev.log('error');
      // verificationCodeController.pinController.text = '';
      // verificationCodeController.isButtonActive.value = false;
      isLoading.value = false;
   //   Get.off(()=> VerificationCodeView());
    });
  }



}
