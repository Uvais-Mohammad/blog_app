import 'package:blog_app/src/core/models/users.dart';
import 'package:blog_app/src/core/services/users_service.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UsersViewModel extends ReactiveViewModel {
  final TextEditingController searchController = TextEditingController();
  List<User> usersList = [];
  Stream<List<User>> get users => serviceLocator<UsersService>().users;

  Stream<List<User>> searchUsers(String searchField) {
    serviceLocator<UsersService>().users.map((users) {
      usersList = users;
    });
    return Stream.value(usersList.where((user) {
      return user.userName!.toLowerCase().contains(searchField.toLowerCase()) ||
          user.email.toLowerCase().contains(searchField.toLowerCase());
    }).toList());
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
