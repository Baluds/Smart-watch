import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  final firebaseAuth = FirebaseAuth.instance;
  final users = FirebaseFirestore.instance.collection('users');

  Future signIn(String email, String pass) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: pass);
    return userCredential.user?.uid;
  }

  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }

  Future signUp(String email, String pass, String name) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: pass);
    await createUser(userCredential.user!, name);
    return userCredential.user?.uid;
  }

  Future createUser(User user, String name) async {
    return users
        .doc(user.uid)
        .set({
          'Name': name,
          'Email': user.email,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    return user;
  }
}
