import 'package:blog_app/src/core/services/auth_service.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  String? errorMessage;

  Future<bool> signUp() async {
    setBusy(true);
    try {
      var result =
          await serviceLocator<AuthService>().createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
        userName: usernameController.text,
      );
      return result;
    } catch (e) {
      errorMessage = e.toString();
      setBusy(false);

      return false;
    }
  }
}
