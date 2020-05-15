import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:virtual_mall/core/models/user.dart';

import 'base_auth.dart';

class AppFirebaseAuth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Firestore _firebaseStore = Firestore.instance;

  @override
  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  @override
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user
        .uid;
  }

  @override
  Future<User> currentUser() async {
    final firebaseUser = await _firebaseAuth.currentUser();

    if (firebaseUser == null) return null;
    await writeUserData(firebaseUser);

    return User(
        id: firebaseUser.uid,
        name: firebaseUser.displayName,
        email: firebaseUser.email);
  }

  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user
        .uid;
  }

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount account = await _googleSignIn.signIn();

    if (account == null) return null;

    final GoogleSignInAuthentication _auth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: _auth.accessToken,
      idToken: _auth.idToken,
    );
    final firebaseUser =
        (await _firebaseAuth.signInWithCredential(credential)).user;
    await writeUserData(firebaseUser);
    final User user = User(
        id: firebaseUser.uid,
        name: firebaseUser.displayName,
        email: firebaseUser.email);
    return user;
  }

  @override
  Future<User> signInWithFacebook() async {
    var facebooklogin = new FacebookLogin();
    var result = await facebooklogin.logIn(['email']);
    FacebookAccessToken myToken = result.accessToken;
    if (result.status != FacebookLoginStatus.loggedIn) {
      return null;
    } else {
      AuthCredential credential =
          FacebookAuthProvider.getCredential(accessToken: myToken.token);

      FirebaseUser firebaseUser =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;

      await writeUserData(firebaseUser);
      final User user = User(
          id: firebaseUser.uid,
          name: firebaseUser.displayName,
          email: firebaseUser.email);
      return user;
    }
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  Future<bool> writeUserData(FirebaseUser firebaseUser) async {
    if (firebaseUser != null) {
      // Check is already sign up
      final QuerySnapshot result =
          await _firebaseStore.collection('users').where('id', isEqualTo: firebaseUser.uid).getDocuments();
      final List < DocumentSnapshot > documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        await Firestore.instance.collection('users').document(firebaseUser.uid).setData(
            { 'nickname': firebaseUser.displayName, 'photoUrl': firebaseUser.photoUrl, 'id': firebaseUser.uid });
      }

      return true;
    }

    return false;
  }

}
