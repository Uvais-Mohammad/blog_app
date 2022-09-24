import 'package:blog_app/src/core/services/auth_service.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;
  Future login(String email, String password) async {
    setBusy(true);
    try {
      var result =
          await serviceLocator<AuthService>().signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      setBusy(false);
      return result;
    } catch (e) {
      errorMessage = e.toString();
      setBusy(false);
      return false;
    }

    
  }

  Future signInWithGoogle(BuildContext context) async {
    setBusy(true);
    try {
      var result =
          await serviceLocator<AuthService>().signInWithGoogle(context);
      return result;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }

    setBusy(false);
  }
}
