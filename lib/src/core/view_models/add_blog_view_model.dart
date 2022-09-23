import 'package:blog_app/src/core/services/blog_service.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class BlogViewModel extends ReactiveViewModel {
  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
List<String> categories = [
    
    "Sports",
    "Movies",
  ];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  XFile? selectedImage;
  String? errorMessage;
  String? category;

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = image;
    notifyListeners();
  }

  Future<bool> addBlog() async {
    setBusy(true);
    bool res= await serviceLocator<BlogService>().addBlog(
        title: titleController.text,
        content: contentController.text,
        image: selectedImage,
        category: category!);
    setBusy(false);
    return res;
  }

  void onChangedCategory(String? value) {
    category = value;
    notifyListeners();
  }
  // Future<bool> addBlog(String title, String content) async {}
}
