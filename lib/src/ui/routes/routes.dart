import 'package:blog_app/src/ui/views/add_blog_screen.dart';
import 'package:blog_app/src/ui/views/home_screen.dart';
import 'package:blog_app/src/ui/views/login_screen.dart';
import 'package:blog_app/src/ui/views/profile_view.dart';
import 'package:blog_app/src/ui/views/sign_up_screen.dart';
import 'package:blog_app/src/ui/views/users_screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  '/home': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/signUp': (context) => const SignUpScreen(),
  '/addBlog': (context) => const AddBlogScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/users': (context) => const UsersScreen(),
};
