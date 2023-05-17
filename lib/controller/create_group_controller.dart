import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateGroupController{
  static final User? user=FirebaseAuth.instance.currentUser;
  static final CollectionReference<Map<String, dynamic>> groupsRef = FirebaseFirestore.instance.collection('groups');
  static final CollectionReference<Map<String, dynamic>> usersRef = FirebaseFirestore.instance.collection('users');

  static Future<bool> crateGroup(String groupName)async{
    await groupsRef.doc(groupName).set({
      "mates":[user!.email],
      "chores":[],
    }).then((value) {
      print("Group $groupName created successfully");
      return Future.value(true);
    })
        .catchError((error) {
      print("Failed to create group: $error");
      return Future.value(false);
    });
    return Future.value(false);
  }

  static Future<dynamic> getMembersList(String groupName)async{
   // Future<List> members=[];
   var  group = await groupsRef.doc(groupName).get();
    var members=group["mates"];
    return Future.value(members);
  }

  static  ifGroupExists(String groupName) async {
    await groupsRef.doc(groupName).get().then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if(documentSnapshot.exists){
        return true;
      }
      else{
        return false;
      }
    });
    return false;
  }
  static getGroupName()async{
    var groupName="";
    await usersRef.doc(user!.uid).get().then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      groupName=documentSnapshot["groupId"];
    }).onError((error, stackTrace){
      print("Error in getting user's group id: $error");
      return Future.value(null);
    });
    return Future.value(groupName);
  }

  static findUserByEmail(String email)async{
    var userName="";
    var userId="";
    await usersRef.where("email",isEqualTo: email).get().then((value) {
      if(value.docs.isNotEmpty){
        userName=value.docs.first["username"];
        userId=value.docs.first.id;
      }
    });
    var nameAndId=[userName,userId];
    return Future.value(nameAndId);


  }
  static addMember(String emailAddress){
    usersRef.where("email",isEqualTo: emailAddress).get().then((value) {
      if(value.docs.isNotEmpty){
        var userId=value.docs.first.id;
        usersRef.doc(userId).update({
          "groupId":getGroupName(),
        });
        groupsRef.doc(getGroupName()).update({
          "mates":FieldValue.arrayUnion([emailAddress]),
        });
      }
    });
  }


  static addGroupIdInUserRef(List<String> memberIds,String groupName)async{
    for(var i=0;i<memberIds.length;i++){
      await usersRef.doc(memberIds[i]).update({
        "groupIds":[groupName],
      });
    }


  }


  static createGroup(String groupName, List<String> memberIds){
    groupsRef.doc(groupName).set({
      "mates":memberIds,
      "chores":[],
    }).then((value) {
      addGroupIdInUserRef(memberIds, groupName);
      print("Group $groupName created successfully");
      return Future.value(true);
    }).catchError((error) {
      print("Failed to create group: $error");
      return Future.value(false);
    });
    return Future.value(false);
  }

}
