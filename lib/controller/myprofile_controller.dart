
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProfileController{
  static final User? user=FirebaseAuth.instance.currentUser;
  static final userRef=FirebaseFirestore.instance.collection("users").doc(user!.uid);


  static Future<String>  getUserName() async{
    return userRef.get().then((value) => value.data()!["username"]);

  }
  static Future<String> getCurrentEmail(){
    return userRef.get().then((value) => value.data()!["email"]);
  }
  static Future<String> getPhoneNumber(){
    return userRef.get().then((value) => value.data()!["phoneNumber"]);
  }

  static getDateOfBirth(){
    return userRef.get().then((value) => value.data()!["dateOfBirth"]);
  }

  static updateUserName(String username){
    userRef.update({"username":username});
  }
  static updatePhoneNumber(String phoneNumber){
    userRef.update({"phoneNumber":phoneNumber});
  }
  static updateDateOfBirth(String dateOfBirth){
    userRef.update({"dateOfBirth":dateOfBirth});
  }

  static Future<void> updateUser(
      String username,
      String phoneNumber,
      String dateOfBirth
      )async {
   await userRef.update({
      "username":username??user!.displayName,
      "phoneNumber":phoneNumber??"null",
      "dateOfBirth":dateOfBirth??user!.metadata.creationTime.toString().substring(0,10)
    });


  }
}