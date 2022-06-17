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

  Future signUp(
    String email,
    String pass,
    String name,
    String phone,
    String emerg1,
    String emerg2,
    String emerg3,
    String emerg4,
    String emerg1m,
    String emerg2m,
    String emerg3m,
    String emerg4m,
    bool pregnantBool,
    int pregnancy,
  ) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: pass);
    await createUser(userCredential.user!, name, phone, emerg1, emerg2, emerg3,
        emerg4, emerg1m, emerg2m, emerg3m, emerg4m, pregnantBool, pregnancy);
    await signOut(); //signup automatically signs in suer so to avoid that added this
    return userCredential.user?.uid;
  }

  Future createUser(
    User user,
    String name,
    String phone,
    String emerg1,
    String emerg2,
    String emerg3,
    String emerg4,
    String emerg1m,
    String emerg2m,
    String emerg3m,
    String emerg4m,
    bool pregnantBool,
    int pregnancy,
  ) async {
    return users
        .doc(user.uid)
        .set({
          'Name': name,
          'Email': user.email,
          'Uid': user.uid,
          'Phone': phone,
          'EmergencyContact1': emerg1,
          'EmergencyContact2': emerg2,
          'EmergencyContact3': emerg3,
          'EmergencyContact4': emerg4,
          'EmergencyContact1mail': emerg1m,
          'EmergencyContact2mail': emerg2m,
          'EmergencyContact3mail': emerg3m,
          'EmergencyContact4mail': emerg4m,
          'IsPregnant': pregnantBool,
          'Pregnancy': pregnancy,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    return user;
  }

  Future updateUser(Map profile) {
    return users.doc(profile['Uid']).update({
      'Name': profile['Name'],
      'Phone': profile['Phone'],
      'EmergencyContact1': profile['EmergencyContact1'],
      'EmergencyContact2': profile['EmergencyContact2'],
      'EmergencyContact3': profile['EmergencyContact3'],
      'EmergencyContact4': profile['EmergencyContact4'],
      'EmergencyContact1mail': profile['EmergencyContact1mail'],
      'EmergencyContact2mail': profile['EmergencyContact2mail'],
      'EmergencyContact3mail': profile['EmergencyContact3mail'],
      'EmergencyContact4mail': profile['EmergencyContact4mail'],
      'IsPregnant': profile['IsPregnant'],
      'Pregnancy': profile['Pregnancy'],
    });
  }

  Future getData(String uid) async {
    var document;
    await users.doc(uid).get().then((event) {
      document = event.data();
    });
    return document;
  }
}
