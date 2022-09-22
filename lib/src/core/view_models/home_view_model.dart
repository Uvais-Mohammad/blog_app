import 'package:blog_app/src/core/services/auth_service.dart';
import 'package:blog_app/src/core/services/firestore_service.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends ReactiveViewModel {
  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
  Stream<QuerySnapshot<Map>> get blogs => serviceLocator<FirestoreService>().getBlogs();
  String? userPhotoUrl=serviceLocator<AuthService>().currentUser!.photoURL;
  void signOut() async{
    await serviceLocator<AuthService>().signOut();
  }
}
