import 'package:blog_app/firebase_options.dart';
import 'package:blog_app/src/my_app.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint('backgroundHandler: ${message.messageId}');
  debugPrint(message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  
  await setupServiceLocator();
  runApp(const MyApp());
}
