import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based off returned firebase user object
  User _userfromFireBaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }
  
  Future anonSignIn() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userfromFireBaseUser(user);
    } catch(err) {
      print(err.toString());
      return null;
    }
  }
}