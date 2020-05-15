import 'dart:async';

import 'package:virtual_mall/core/models/user.dart';
import 'firebase_auth.dart';

class AuthenticationService {
  AppFirebaseAuth api;

  StreamController<User> _userController = StreamController<User>();
  Stream<User> get user => _userController.stream;

  Future getLoggedUser() async {
    await new Future.delayed(const Duration(seconds: 2));
    var fetchedUser = await api.currentUser();
    var hasUser = fetchedUser != null;
    if (hasUser) {
      _userController.add(fetchedUser);
    } else {
      _userController.add(User(id: null));
    }
  }

  Future<bool> googleSignIn() async {
    var fetchedUser = await api.signInWithGoogle();
    var hasUser = fetchedUser != null;
    if (hasUser) {
      _userController.add(fetchedUser);
    }
    return hasUser;
  }

  Future<bool> facebookSignIn() async {
    var fetchedUser = await api.signInWithFacebook();
    var hasUser = fetchedUser != null;
    if (hasUser) {
      _userController.add(fetchedUser);
    }
    return hasUser;
  }

  dispose() {
    _userController.close();
  }
}