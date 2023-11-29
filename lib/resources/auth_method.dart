// ignore_for_file: unnecessary_null_comparison, avoid_print, unused_local_variable


import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';
import 'package:instagram_flutter/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }
  
  // sign up user
  Future<String> signUpUser({
    required String email,
    required String username,
    required String password,
    required String bio,
    required Uint8List file
  }) async {
    String res = "some error ocurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty || file != null) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
          
        print(cred.user!.uid);

        String photoURL = await StorageMethods().uploadImageToStorage('profilePics', file, false);

        model.User user = model.User(
          email: email, 
          uid: cred.user!.uid, 
          photoURL: photoURL, 
          username: username, 
          bio: bio, 
          followers: [], 
          following: []
        );

        // add user to database
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
        res = 'success';
      }

    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //log in user
  Future<String> loginUser ({
    required String email,
    required String password,
  }) async {
    String res = 'some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        res = 'The user is not founded';
      } else if (err.code == 'wrong-password') {
        res = 'wrong password';
      }
    } 
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

}