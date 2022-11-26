import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/remote/Api_request.dart';
import 'package:get/get.dart';

import 'dart:developer' as dev;



class ResetPasswordService {
  /// initialization of instance
  static ResetPasswordService? _instance;

  /// Function used to create an instance
  static ResetPasswordService? getInstance() {
    _instance ??= ResetPasswordService();
    return _instance;
  }

  /// Create a function to get the data from the backend
  Future resetPassword({
    Function? onSuccess,
    Function? onError ,
    String? code ,
    String? password}) async {
    try {
      String url = "auth/reset-password";
      dev.log(url);

      var response = await ApiRequest(
        url: url,
        data: {
          "code": code! ,
          "password": password!,
          "passwordConfirmation": password
        },
        queryParameters: {},
      ).post(onError:  onError!(),onSuccess: onSuccess!());
    } catch (e) {
      onError!(e);
    }
  }
}