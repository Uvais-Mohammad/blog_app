import 'package:blog_app/firebase_options.dart';
import 'package:blog_app/src/my_app.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupServiceLocator();
  runApp(const MyApp());
}
