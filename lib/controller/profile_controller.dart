
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController{
  static final CollectionReference<Map<String, dynamic>>  usersRef = FirebaseFirestore.instance.collection("users");
  static final String currentUserID = FirebaseAuth.instance.currentUser!.uid.toString();
  static final DocumentReference<Map<String, dynamic>> currentUserRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);



  static getUserName() async{
    final currentUser = await currentUserRef.get();
    print(await currentUser.data()!["username"]);
    return currentUser.data()!["username"]?? "No username";
  }

  static getProfession() async{
    final currentUser = await currentUserRef.get();
    print(await currentUser.data()!["profession"]);
    return currentUser.data()!["profession"]?? "No profession";
  }

  static getUserEmail() async{
    final currentUser = await currentUserRef.get();
    print(await currentUser.data()!["email"]);
    return currentUser.data()!["email"]?? "No email";
  }

  static getChoresCompleted() async{
    final currentUser = await currentUserRef.get();
    print(await currentUser.data()!["choresCompleted"]);
    return currentUser.data()!["choresCompleted"]?? "No chores completed";
  }

  static Future<bool> signOut() async{
    try{
      await FirebaseAuth.instance.signOut();
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }



}