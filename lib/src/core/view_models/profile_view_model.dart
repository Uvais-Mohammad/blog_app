import 'package:blog_app/src/core/services/auth_service.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends ReactiveViewModel {

  User user = serviceLocator<AuthService>().currentUser!;
  Future<void> signOut() async{
    await serviceLocator<AuthService>().signOut();
  }
  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
