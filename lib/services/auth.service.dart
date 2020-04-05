import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebase user
  User _getUserFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_getUserFromFirebaseUser);
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      AuthResult res = await _auth.signInAnonymously();
      FirebaseUser user = res.user;
      return _getUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, password) async{
    try {
      AuthResult res = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = res.user;
      return _getUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async{
    try {
      AuthResult res = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = res.user;
      // create a new document  for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);

      return _getUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      String errMsg = e.toString();
      print('sign out error $errMsg');
    }
  }

}