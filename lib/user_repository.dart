import 'package:meta/meta.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:login_app/bloc/flags.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SharedPreferences prefs;

  Future<String> authenticate({
    @required String username,
    @required String password,
    @required Flags flag,
  }) async {
    String _token;
    switch (flag) {
      case Flags.email:
        try {
          FirebaseUser user = await _auth.signInWithEmailAndPassword(
              email: username, password: password);
          _token = await user.getIdToken();
        } catch (e) {
          throw 'Failed';
        }
        return _token;
      case Flags.google:
        try {
          GoogleSignIn _googleSignIn = GoogleSignIn();
          GoogleSignInAccount googleUser = await _googleSignIn.signIn();
          GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          FirebaseUser user = await _auth.signInWithGoogle(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          _token = await user.getIdToken();
          _googleSignIn.disconnect();
        } catch (e) {
          throw 'Failed';
        }
        return _token;
    }
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await _auth.signOut();
    prefs = await SharedPreferences.getInstance();
    prefs.remove('Token');

    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    prefs = await SharedPreferences.getInstance();
    prefs.setString('Token', token);

    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    prefs = await SharedPreferences.getInstance();
    String result;
    result = prefs.getString('Token') ?? 'false';
    if (result != 'false') {
      return true;
    } else {
      return false;
    }
  }
}
