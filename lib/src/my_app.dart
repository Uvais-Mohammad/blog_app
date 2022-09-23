import 'package:blog_app/src/core/services/auth_service.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:blog_app/src/ui/views/add_blog_screen.dart';
import 'package:blog_app/src/ui/views/home_screen.dart';
import 'package:blog_app/src/ui/views/login_screen.dart';
import 'package:blog_app/src/ui/views/profile_view.dart';
import 'package:blog_app/src/ui/views/sign_up_screen.dart';
import 'package:blog_app/src/ui/views/users_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signUp': (context) => const SignUpScreen(),
        '/addBlog': (context) => const AddBlogScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/users': (context) => const UsersScreen(),
      },
      home: StreamBuilder(
          stream: serviceLocator<AuthService>().authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }
            if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          }),
    );
  }
}
