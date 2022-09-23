import 'package:blog_app/src/core/models/users.dart';
import 'package:blog_app/src/core/services/firestore_service.dart';
import 'package:blog_app/src/service_locator.dart';

class UsersService {
  Stream<List<User>> get users {
    return serviceLocator<FirestoreService>().getData('users').map((snapshot) {
      return snapshot.docs
          .map((doc) => User(
                uid: doc.data()['uid'],
                email: doc.data()['email'],
                userName: doc.data()['userName'],
                profilePhoto: doc.data()['profilePhoto'],
              ))
          .toList();
    });
  }
}
