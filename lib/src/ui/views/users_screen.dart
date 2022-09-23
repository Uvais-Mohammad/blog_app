import 'package:blog_app/src/core/models/users.dart';
import 'package:blog_app/src/core/utils/user_search_delegate.dart';
import 'package:blog_app/src/core/view_models/users_view_model.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
     List<User> usersList = [];
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => serviceLocator<UsersViewModel>(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Users'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(usersList:usersList ),
                    );
                  },
                ),
              ],
            ),
            body: StreamBuilder(
              stream: model.users,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  usersList=snapshot.data as List<User>;
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index].userName),
                        leading: CircleAvatar(
                          backgroundImage: snapshot.data[index].profilePhoto !=
                                  null
                              ? NetworkImage(snapshot.data[index].profilePhoto)
                              : null,
                          child: snapshot.data[index].profilePhoto == null
                              ? Text(snapshot.data[index].userName[0])
                              : null,
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        });
  }
}
