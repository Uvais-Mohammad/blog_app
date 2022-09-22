import 'package:blog_app/src/core/services/auth_service.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends ReactiveViewModel {
  @override
  List<ReactiveServiceMixin> get reactiveServices => [];

  void signOut() async{
    await serviceLocator<AuthService>().signOut();
  }
}
