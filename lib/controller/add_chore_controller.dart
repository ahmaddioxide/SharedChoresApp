import 'firebase_controller.dart';

class AddChoreController {
   String choreTypeSelected = "Weekly";
   Future<bool> addChore(String groupId, String choreName,
      String choreDescription, String choreDate, String choreTime) async {
    try {
      await FirebaseController.groupsRef.doc(groupId).collection("chores").add(
        {
          "choreName": choreName,
          "choreDescription": choreDescription,
          "choreType": choreTypeSelected,
          "choreDate": choreDate,
          "choreTime": choreTime,
          // "choreStatus": "Pending",
          // "choreAssignedTo": "",
          // "choreAssignedBy": "",
          // "choreAssignedToId": "",
          // "choreAssignedById": "",
          // "choreCompletedBy": "",
          // "choreCompletedById": "",
          // "choreCompletedDate": "",
          // "choreCompletedTime": "",
        },
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // static Future<String> getUserGroupId() async {
  //   String groupId = "";
  //   await FirebaseController.usersRef
  //       .doc(FirebaseController.user!.uid)
  //       .get()
  //       .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
  //     groupId = documentSnapshot["groupId"];
  //
  //   }).onError((error, stackTrace) {
  //     print("Error in getting user's group id: $error");
  //     return Future.value(null);
  //   });
  //   return Future.value(groupId);
  // }

  // static Future<List<dynamic>> getListOfMatesEmails()async{
  //   var groups= await getAllGroupIds();
  //   if(groups.isEmpty) {
  //     return Future.value([]);
  //   } else
  //     {
  //       var groupId=await getGroupIdContainsCurrentUser();
  //       if(groupId=="") {
  //         return Future.value([]);
  //       } else
  //         {
  //           //return emails of all mates in this group
  //           List<dynamic> matesEmails=[];
  //           await groupsRef.doc(groupId).get().then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
  //             matesEmails=documentSnapshot["mates"];
  //           });
  //           return Future.value(matesEmails);
  //         }
  //
  //     }
  // }
  //
  // static Future<List<String>> getAllUsersEmails()async
  // {
  //   List<String> usersEmails = [];
  //  await usersRef.get().then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       usersEmails.add(doc["email"]);
  //     });
  //   });
  //   return Future.value(usersEmails);
  // }
  //
  // static Future<List<String>> getAllGroupIds()async
  // {
  //   List<String> groups = [];
  //  await groupsRef.get().then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       groups.add(doc.id);
  //     });
  //   }).onError((error, stackTrace) {
  //     print(error);
  //  });
  //
  //   return Future.value(groups);
  // }
  //
  // static Future<dynamic> getGroupIdContainsCurrentUser()async
  // {
  //   String groupId = "";
  //   var groupIds= await getAllGroupIds();
  //   var currentUserEmail=FirebaseAuth.instance.currentUser!.email;
  //   for(var i=0;i<groupIds.length;i++)
  //     {
  //       var matesEmails=[];
  //       var groupData;
  //       await groupsRef.doc(groupIds[i]).get().then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) async {
  //         // matesEmails=documentSnapshot.toString();
  //          groupData=await documentSnapshot.data();
  //
  //       });
  //       if(groupData.toString().contains(currentUserEmail.toString()))
  //         {
  //           groupId=groupIds[i];
  //           print(groupId);
  //           break;
  //         }
  //
  //
  //     }
  //   print(groupId);
  //
  //   //searching which group have this user email address
  //
  //
  // }
}
