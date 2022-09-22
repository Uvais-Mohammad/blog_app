import 'package:blog_app/src/core/view_models/home_view_model.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:blog_app/src/ui/widgets/blogs_tile.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => serviceLocator<HomeViewModel>(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
              actions: [
                IconButton(
                  onPressed: () {
                    model.signOut();
                  },
                  icon: const Icon(Icons.logout),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: model.userPhotoUrl != null
                          ? Image.network(model.userPhotoUrl!)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: const Icon(
                                Icons.person,
                                size: 30,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            body: StreamBuilder(
              stream: model.blogs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return BlogsTile(
                        title: snapshot.data!.docs[index].data()['title'],
                        description:
                            snapshot.data!.docs[index].data()['description'] ??
                                '',
                        imgUrl:
                            snapshot.data!.docs[index].data()['imgUrl'] ?? 'https://via.placeholder.com/600x400',
                      );
                    });
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addBlog');
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}
