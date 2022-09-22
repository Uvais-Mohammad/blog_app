import 'package:blog_app/src/core/view_models/login_view_model.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => serviceLocator<LoginViewModel>(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Login'),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: model.emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    TextField(
                      controller: model.passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    model.errorMessage != null
                        ? Text(model.errorMessage!)
                        : const SizedBox.shrink(),
                    model.isBusy
                        ? const CircularProgressIndicator.adaptive()
                        : const SizedBox.shrink(),
                    ElevatedButton(
                      onPressed: () {
                        model.login(model.emailController.text,
                            model.passwordController.text);
                      },
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 60),
                    ElevatedButton(
                      onPressed: () {
                        model.signInWithGoogle(context);
                      },
                      child: const Text('Sign in with Google'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signUp');
                      },
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
