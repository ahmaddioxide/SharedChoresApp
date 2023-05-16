import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddChoreController{
  static CollectionReference<Map<String, dynamic>> groupsRef = FirebaseFirestore.instance.collection('groups');
  static CollectionReference<Map<String, dynamic>> usersRef = FirebaseFirestore.instance.collection('users');


  static Future<List<dynamic>> getListOfMatesEmails()async{
    var groups= await getAllGroupIds();
    if(groups.isEmpty) {
      return Future.value([]);
    } else
      {
        var groupId=await getGroupIdContainsCurrentUser();
        if(groupId=="") {
          return Future.value([]);
        } else
          {
            //return emails of all mates in this group
            List<dynamic> matesEmails=[];
            await groupsRef.doc(groupId).get().then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
              matesEmails=documentSnapshot["mates"];
            });
            return Future.value(matesEmails);
          }

      }
  }

  static Future<List<String>> getAllUsersEmails()async
  {
    List<String> usersEmails = [];
   await usersRef.get().then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        usersEmails.add(doc["email"]);
      });
    });
    return Future.value(usersEmails);
  }

  static Future<List<String>> getAllGroupIds()async
  {
    List<String> groups = [];
   await groupsRef.get().then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        groups.add(doc.id);
      });
    }).onError((error, stackTrace) {
      print(error);
   });

    return Future.value(groups);
  }

  static Future<dynamic> getGroupIdContainsCurrentUser()async
  {
    String groupId = "";
    var groupIds= await getAllGroupIds();
    var currentUserEmail=FirebaseAuth.instance.currentUser!.email;
    for(var i=0;i<groupIds.length;i++)
      {
        var matesEmails=[];
        var groupData;
        await groupsRef.doc(groupIds[i]).get().then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) async {
          // matesEmails=documentSnapshot.toString();
           groupData=await documentSnapshot.data();

        });
        if(groupData.toString().contains(currentUserEmail.toString()))
          {
            groupId=groupIds[i];
            print(groupId);
            break;
          }


      }
    print(groupId);

    //searching which group have this user email address


  }
}