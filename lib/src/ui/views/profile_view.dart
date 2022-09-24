import 'package:blog_app/src/core/view_models/profile_view_model.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
        viewModelBuilder: () => serviceLocator<ProfileViewModel>(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Profile"),
              actions: [IconButton(
                  onPressed: () {
                    model.signOut().then((value) {
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    });
                    
                  },
                  icon: const Icon(Icons.logout),
                ),],
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: model.user.photoURL != null
                        ? Image.network(model.user.photoURL!)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: const Icon(
                              Icons.person,
                              size: 30,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(model.user.displayName??''),
                const SizedBox(
                  height: 20,
                ),
                Text(model.user.email??''),
                const SizedBox(
                  height: 20,
                ),
                Text(model.user.phoneNumber??''),
              ],
            ),
          );
        });
  }
}
