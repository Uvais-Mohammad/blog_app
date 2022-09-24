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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: model.emailController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextField(
                        controller: model.passwordController,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        obscureText: true,
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
                      const SizedBox(
                        height: 16.0,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          model
                              .login(model.emailController.text,
                                  model.passwordController.text)
                              .then((value) {
                            if (value) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/home', (route) => false);
                            }
                              });
                        },
                        label: const Text('Login'),
                        icon: const Icon(Icons.login),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Expanded(child: Divider()),
                            SizedBox(width: 10.0),
                            Text('OR'),
                            SizedBox(width: 10.0),
                            Expanded(child: Divider()),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          model.signInWithGoogle(context).then((value) {
                            if (value) {
                              Navigator.pushNamed(context, '/home');
                            }
                          });
                        },
                        label: const Text('Sign in with Google'),
                        icon: const Icon(Icons.account_circle),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signUp');
                        },
                        label: const Text('Sign up'),
                        icon: const Icon(Icons.account_circle),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
