import 'package:blog_app/src/core/view_models/signup_view_model.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => serviceLocator<SignUpViewModel>(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('SignUp'),
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
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        model
                            .signUp(model.emailController.text,
                                model.passwordController.text)
                            .then((value) => {
                                  if (value)
                                    {
                                      Navigator.pushNamed(context, '/home')
                                    }
                                }
                                );
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
