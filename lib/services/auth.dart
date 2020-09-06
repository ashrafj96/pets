import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pets/services/api_path.dart';

class User {
  User(
      {@required this.uid,
      @required this.displayName,
      @required this.photoUrl,
      this.isAnonymous});
  final String uid;
  final String photoUrl;
  final String displayName;
  final bool isAnonymous;

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'photoUrl': photoUrl,
      // 'email': email
    };
  }
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(
      String email, String password, String displayName);
  Future<User> signInWithGoogle();
  // Future<User> signInWithFacebook();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(
        uid: user.uid,
        displayName: user.displayName,
        photoUrl: user.photoUrl,
        isAnonymous: user.isAnonymous);
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password, String displayName) async {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = displayName;

    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    await authResult.user.updateProfile(updateInfo);
    await authResult.user.reload();

    FirebaseUser updatedUser = await _firebaseAuth.currentUser();

    final path = APIPath.user(authResult.user.uid);
    final documentReference = Firestore.instance.document(path);
    await documentReference
        .setData({'email': email, 'displayName': displayName});
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  // @override
  // Future<User> signInWithFacebook() async {
  //   final facebookLogin = FacebookLogin();
  //   final result = await facebookLogin.logInWithReadPermissions(
  //     ['public_profile'],
  //   );
  //   if (result.accessToken != null) {
  //     final authResult = await _firebaseAuth.signInWithCredential(
  //       FacebookAuthProvider.getCredential(
  //         accessToken: result.accessToken.token,
  //       ),
  //     );
  //     return _userFromFirebase(authResult.user);
  //   } else {
  //     throw PlatformException(
  //       code: 'ERROR_ABORTED_BY_USER',
  //       message: 'Sign in aborted by user',
  //     );
  //   }
  // }

  // Future<void> createUser(Map<String, dynamic> userData, String uid) async {
  //   final path = '/users/$uid/';
  //   final documentReference = Firestore.instance.document(path);
  //   await documentReference.setData(userData);
  // }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    if (googleSignIn.currentUser != null) {
      await googleSignIn.signOut();
    }
    // final facebookLogin = FacebookLogin();
    // if (facebookLogin.isLoggedIn != false) {
    //   await facebookLogin.logOut();
    // }
    await _firebaseAuth.signOut();
  }
}
