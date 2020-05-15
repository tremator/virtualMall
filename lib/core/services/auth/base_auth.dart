import 'package:virtual_mall/core/models/user.dart';

abstract class BaseAuth {
  Stream<String> get onAuthStateChanged;
  Future<String> signInWithEmailAndPassword(
      String email,
      String password,
      );
  Future<String> createUserWithEmailAndPassword(
      String email,
      String password,
      );

  Future<User> currentUser();
  Future<void> signOut();
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
}