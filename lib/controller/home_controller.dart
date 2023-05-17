import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController {
  static final User? user = FirebaseAuth.instance.currentUser;
  static final CollectionReference<Map<String, dynamic>> groupsRef =
      FirebaseFirestore.instance.collection('groups');
  static final CollectionReference<Map<String, dynamic>> usersRef = FirebaseFirestore.instance.collection('users');


  static Future<dynamic> getListOfGroups() async {

    var currentUser=await usersRef.doc(user!.uid).get();
    var groups=currentUser["groupIds"];
    // if(groups==null){
    //   return Future.value([]);
    // }
    return Future.value(groups);
  }


}