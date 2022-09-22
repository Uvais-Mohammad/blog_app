import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<bool> addBlog(
      {required String title,
      required String content,
      String? image,
      required String category}) async {
    bool res = true;
    String? imageUrl;
    try {
      await _firestore.collection('blogs').add({
        'title': title,
        'content': content,
        'image': imageUrl,
        'category': category,
      });
      res = true;
      return res;
    } catch (e) {
      res = false;
      return res;
    }
  }

  Future<String?> addImage({required XFile file}) async {
    String? imageUrl;
    try {
      final storageRef = _storage
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");
      await storageRef.putFile(File(file.path));
      imageUrl = await storageRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future addUser(User user) async {
    try {
      await _firestore.collection('user').doc(user.uid).set({
        'username': user.displayName,
        'uid': user.uid,
        'profilePhoto': user.photoURL,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String randomAlphaNumeric(int i) {
    var random = Random.secure();
    var values = List<int>.generate(i, (i) => random.nextInt(255));
    return base64Url.encode(values);
  }

   Stream<QuerySnapshot<Map>> getBlogs()  {
    return  _firestore.collection('blogs').snapshots();
  }
}
