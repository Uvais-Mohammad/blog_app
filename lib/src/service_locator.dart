import 'package:blog_app/src/core/services/auth_service.dart';
import 'package:blog_app/src/core/services/blog_service.dart';
import 'package:blog_app/src/core/services/firestore_service.dart';
import 'package:blog_app/src/core/services/local_notification_service.dart';
import 'package:blog_app/src/core/services/users_service.dart';
import 'package:blog_app/src/core/view_models/add_blog_view_model.dart';
import 'package:blog_app/src/core/view_models/home_view_model.dart';
import 'package:blog_app/src/core/view_models/login_view_model.dart';
import 'package:blog_app/src/core/view_models/profile_view_model.dart';
import 'package:blog_app/src/core/view_models/signup_view_model.dart';
import 'package:blog_app/src/core/view_models/users_view_model.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  await _registerServices();
  _registerViewModels();
}

Future<void> _registerServices() async {
  serviceLocator.registerLazySingleton(() => AuthService());
  serviceLocator.registerLazySingleton(() => FirestoreService());
  serviceLocator.registerLazySingleton(() => BlogService());
  serviceLocator.registerLazySingleton(() => UsersService());
  serviceLocator.registerLazySingleton(() => LocalNotificationService());
}

void _registerViewModels() async {
   serviceLocator.registerFactory(() => LoginViewModel());
   serviceLocator.registerFactory(() => HomeViewModel());
   serviceLocator.registerFactory(() => SignUpViewModel());
   serviceLocator.registerFactory(() => BlogViewModel());
   serviceLocator.registerFactory(() => ProfileViewModel());
   serviceLocator.registerFactory(() => UsersViewModel());
}
