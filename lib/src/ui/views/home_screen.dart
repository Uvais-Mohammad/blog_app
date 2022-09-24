import 'package:blog_app/src/core/services/local_notification_service.dart';
import 'package:blog_app/src/core/view_models/home_view_model.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:blog_app/src/ui/widgets/blogs_tile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    serviceLocator<LocalNotificationService>().requestPermission();
    serviceLocator<LocalNotificationService>().getToken();

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      debugPrint('getInitialMessage: ${message?.messageId}');
      debugPrint('New message: ${message?.messageId}');
      debugPrint(message?.data.toString());
      // final routeFromMessage = message.data['route'];
      // Navigator.pushNamed(context, '/home');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint('onMessageOpenedApp: ${message.messageId}');
      debugPrint('New message: ${message.messageId}');
      debugPrint(message.data.toString());
      serviceLocator<LocalNotificationService>()
          .createAndDisplayNotification(message);
    });

    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('onMessage: ${message.messageId}');
      debugPrint('New message: ${message.data}');
      debugPrint(message.data.toString());
serviceLocator<LocalNotificationService>()
          .createAndDisplayNotification(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => serviceLocator<HomeViewModel>(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Welcome Back👋🏻'),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/users');
                  },
                  icon: const Icon(Icons.people),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/profile');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: model.userPhotoUrl != null
                          ? Image.network(model.userPhotoUrl!)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: const Icon(
                                Icons.person_rounded,
                                size: 30,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            body: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ChoiceChip(
                          label: Text(
                            model.categories[index],
                            style: const TextStyle(),
                          ),
                          selected:
                              model.selectedCategory == model.categories[index],
                          onSelected: (selected) {
                            model.selectedCategory = model.categories[index];
                          },
                        ),
                      );
                    },
                  ),
                ),
                StreamBuilder(
                  stream: model.filteredBlogs,
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
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return BlogsTile(
                            title: snapshot.data!.docs[index].data()['title'],
                            description:
                                snapshot.data!.docs[index].data()['content'] ??
                                    '',
                            imgUrl:
                                snapshot.data!.docs[index].data()['image'] ??
                                    'https://via.placeholder.com/600x400',
                            category:
                                snapshot.data!.docs[index].data()['category'],
                          );
                        });
                  },
                ),
              ],
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
