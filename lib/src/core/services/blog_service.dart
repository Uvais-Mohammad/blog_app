

import 'package:blog_app/src/core/services/firestore_service.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class BlogService {
  Future<bool> addBlog(
      {required String title,
      required String content,
      XFile? image,
      required String category}) async {
    bool res = true;
    String? imageUrl;
    try {
      if (image != null) {
        imageUrl =
            await serviceLocator<FirestoreService>().addImage(file: image);
      }

      res = await serviceLocator<FirestoreService>().addBlog(
          title: title, content: content, image: imageUrl, category: category);

      return res;
    } catch (e) {
      res = false;
      return res;
    }
  }

 Stream<QuerySnapshot<Map>> getBlogs()  {
    return  serviceLocator<FirestoreService>().getBlogs();
  }
}
