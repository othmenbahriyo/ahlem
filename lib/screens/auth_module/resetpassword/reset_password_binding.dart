import 'package:flutter_application_1/screens/auth_module/resetpassword/reset_password_controller.dart';
import 'package:get/get.dart';


class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(
      () => ResetPasswordController(),
    );
  }
}
