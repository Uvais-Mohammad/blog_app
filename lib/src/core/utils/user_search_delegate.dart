// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/src/core/models/users.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<User> usersList;
  CustomSearchDelegate({
    required this.usersList,
  });
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final list = query.isEmpty
        ? usersList
        : usersList
            .where((element) =>
                element.userName!.toLowerCase().contains(query) ||
                element.email.toLowerCase().contains(query))
            .toList();
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(list[index].userName!),
        leading: CircleAvatar(
          backgroundImage: list[index].profilePhoto != null
              ? NetworkImage(list[index].profilePhoto!)
              : null,
          child: list[index].profilePhoto == null
              ? Text(list[index].userName![0])
              : null,
        ),
      ),
    );
  }
}
