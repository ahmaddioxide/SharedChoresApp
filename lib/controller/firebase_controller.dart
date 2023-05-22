import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseController{
  static final User? user=FirebaseAuth.instance.currentUser;
  static final CollectionReference<Map<String, dynamic>> groupsRef = FirebaseFirestore.instance.collection('groups');
  static final CollectionReference<Map<String, dynamic>> usersRef = FirebaseFirestore.instance.collection('users');
  static final DocumentReference<Map<String, dynamic>> currentUserRef=FirebaseFirestore.instance.collection("users").doc(user!.uid);
  static final auth = FirebaseAuth.instance;
}