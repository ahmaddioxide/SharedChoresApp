import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? _user = _auth.currentUser;
    return  Scaffold(
      body:  Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              _auth.signOut().then((value) => Navigator.pop(context));
            }, child: const Text("Logout")),
            Text(_user!.toString()),
          ],
        ),
      )
    );
  }
}
