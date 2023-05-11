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
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        // var user= User(userId: value.user!.uid, name: username, email: email, password: password,);
        addUserToFirestore(username, email).then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("User Registered Successfully"),
            ),
          );
        });
      }).onError((error, stackTrace) {
        if (error.toString().contains("email-already-in-use")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Email Already In Use"),
            ),
          );
        } else if (error.toString().contains("weak-password")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password Should Be At Least 6 Characters"),
            ),
          );
        } else if (error.toString().contains("invalid-email")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Invalid Email"),
            ),
          );
        } else if (error.toString().contains("network-request-failed")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Check Your Internet Connection"),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
            ),
          );
        }
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
      debugPrint(error.toString());
    }
  }

  static Future<void> loginUser(
      BuildContext context, String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Login Successful"),
          ),
        );
      }).onError((error, stackTrace) {
        if (error == null) {
        } else if (error.toString().contains("user-not-found")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("User Not Found"),
            ),
          );
        } else if (error.toString().contains("wrong-password")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Wrong Password"),
            ),
          );
        } else if (error.toString().contains("invalid-email")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Invalid Email"),
            ),
          );
        } else if (error.toString().contains("network-request-failed")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Network Request Failed"),
            ),
          );
        } else if (error.toString().contains("too-many-requests")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Too Many Requests"),
            ),
          );
        } else if (error.toString().contains("user-disabled")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("User Disabled"),
            ),
          );
        } else if (error.toString().contains("operation-not-allowed")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Operation Not Allowed"),
            ),
          );
        } else if (error.toString().contains("invalid-credential")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Invalid Credential"),
            ),
          );
        } else if (error
            .toString()
            .contains("account-exists-with-different-credential")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Account Exists With Different Credential"),
            ),
          );
        } else if (error.toString().contains("wrong-password")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Wrong Password"),
            ),
          );
        }
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(error.toString()),
        ),
      );
    }
  }
}