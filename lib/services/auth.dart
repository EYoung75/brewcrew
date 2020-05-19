import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based off returned firebase user object
  User _userfromFireBaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        // .map((FirebaseUser user) => _userfromFireBaseUser(user));
        .map(_userfromFireBaseUser);
  }

  Future anonSignIn() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userfromFireBaseUser(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  Future register(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for user with uid
      await DatabaseService(uid: user.uid).updateUserData("0", "new crew member", 100);
      return _userfromFireBaseUser(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  Future userSignIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userfromFireBaseUser(user);
    } catch(err) {
      print(err.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
