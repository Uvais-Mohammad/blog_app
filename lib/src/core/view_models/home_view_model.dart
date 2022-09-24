import 'package:blog_app/src/core/services/auth_service.dart';
import 'package:blog_app/src/core/services/blog_service.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends ReactiveViewModel {
  List<String> categories = [
    "All",
    "Sports",
    "Movies",
  ];
  String? _selectedCategory = "All";

  User get user => serviceLocator<AuthService>().currentUser!;
  String? get selectedCategory => _selectedCategory;
  set selectedCategory(String? value) {
    _selectedCategory = value;
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
  Stream<QuerySnapshot<Map>> get blogs =>
      serviceLocator<BlogService>().getBlogs();
  //filter blogs
  Stream<QuerySnapshot<Map>> get filteredBlogs {
    if (selectedCategory == "All") {
      return blogs;
    } else {
      return serviceLocator<BlogService>()
          .getBlogsByCategory(selectedCategory!);
    }
  }

  String? userPhotoUrl = serviceLocator<AuthService>().currentUser!.photoURL;
  void signOut() async {
    await serviceLocator<AuthService>().signOut();
  }
}
