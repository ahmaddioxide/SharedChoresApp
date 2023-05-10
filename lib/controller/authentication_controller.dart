import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../view/home_screen.dart';

class AuthenticationController {
  static final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('users');
  static final currentUser = FirebaseAuth.instance.currentUser;

  static Future<void> addUserToFirestore(
    String username,
    String email,
  ) async {
    await _userCollectionReference
        .doc(currentUser?.uid.toString())
        .set(
          {
            'username': username,
            'email': email,
          },
        )
        .then(
          (value) => debugPrint("User Added to FireStore"),
        )
        .catchError(
          (error) => debugPrint("Failed to add user: $error"),
        );
  }

  static Future<void> registerUser(BuildContext context, String username,
      String email, String password) async {

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).whenComplete((){
        addUserToFirestore(username, email);
      } );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("The password provided is too weak."),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("The email address is not valid."),
          ),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString()),
        ),
      );
    }

  }

  static Future<void> loginUser(
      BuildContext context, String email, String password) async {
    User? user;
    try {
      var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      if (error is FirebaseAuthException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(error.message.toString()),
          ),
        );
      }

    }
    // if (errorMessage != null) {
    //   return Future.error(errorMessage);
    // }
    if(user != null){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }


  }
}
