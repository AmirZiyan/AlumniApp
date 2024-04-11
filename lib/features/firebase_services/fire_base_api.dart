import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _auth = FirebaseAuth.instance;
final _db = FirebaseFirestore.instance;
User? user;

class FirebaseApi {
  // sign up alumni with firebase
  static signUpAlumni(
      String email, String password, String name, BuildContext context) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        user = _auth.currentUser;
        return _db.collection('users').add(
          {"alumniName": name, 'AlumniEmail': email, "alumniId": user!.uid},
        ).then(
          (value) {
            return _auth.signOut();
          },
        );
      },
    );
    // log in alumni

    _auth.signInWithEmailAndPassword(email: email, password: password);
  }

 static signInAlumni(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
