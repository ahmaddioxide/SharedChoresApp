import 'package:choresmate/controller/firebase_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateGroupController {


  static Future<bool> crateGroup(String groupName) async {
    await FirebaseController.groupsRef.doc(groupName).set(
      {
        "mates": [FirebaseController.user!.email],
        "chores": [],
      },
    ).then(
      (value) {
        print("Group $groupName created successfully");
        return Future.value(true);
      },
    ).catchError((error) {
      print("Failed to create group: $error");
      return Future.value(false);
    });
    return Future.value(false);
  }

  static Future<List<String>> getMembersList(String groupName) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> group =
          await FirebaseController.groupsRef.doc(groupName).get();
      List<String> members = group["mates"];
      return Future.value(members);
    } on Exception catch (e) {
      print("Error in getting members list: $e");
      return Future.value([]);
    }
  }

  static Future<bool> ifGroupExists(String groupName) async {
    await FirebaseController.groupsRef.doc(groupName).get().then(
      (DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        if (documentSnapshot.exists) {
          return true;
        } else {
          return false;
        }
      },
    );
    return false;
  }

  static Future<String> getGroupName() async {
    var groupName = "";
    await FirebaseController.usersRef.doc(FirebaseController.user!.uid).get().then(
      (DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        groupName = documentSnapshot["groupId"];
      },
    ).onError(
      (error, stackTrace) {
        print("Error in getting user's group id: $error");
        return Future.value(null);
      },
    );
    return Future.value(groupName);
  }

  static Future<List<String>> findUserByEmail(String email) async {
    String userName = "";
    String userId = "";
    await FirebaseController.usersRef.where("email", isEqualTo: email).get().then(
      (value) {
        if (value.docs.isNotEmpty) {
          userName = value.docs.first["username"];
          userId = value.docs.first.id;
        }
      },
    );
    List<String> nameAndId = [userName, userId];
    return Future.value(nameAndId);
  }

  static Future<void> addMember(String emailAddress) async {
    await FirebaseController.usersRef.where("email", isEqualTo: emailAddress).get().then(
      (value) async {
        if (value.docs.isNotEmpty) {
          String userId = value.docs.first.id;
         FirebaseController.usersRef.doc(userId).update(
            {
              "groupId": await getGroupName(),
            },
          );
          await FirebaseController.groupsRef.doc(await getGroupName()).update(
            {
              "mates": FieldValue.arrayUnion(
                [emailAddress],
              ),
            },
          );
        }
      },
    );
  }

  static addGroupIdInUserRef(List<String> memberIds, String groupName) async {
    for (var i = 0; i < memberIds.length; i++) {
      await FirebaseController.usersRef.doc(memberIds[i]).update(
        {
          "groupIds": [groupName],
        },
      );
    }
  }

  static Future<void> createGroup(String groupName, List<String> memberIds) async {
    memberIds.add( FirebaseController.user!.uid);
    memberIds.toSet().toList();
    print("Updated Members IDs: $memberIds");

    await FirebaseController.groupsRef.doc(groupName).set(
      {
        "mates": memberIds,
        "chores": [],
      },
    ).then(
      (value) async {
        await addGroupIdInUserRef(memberIds, groupName);
        print("Group $groupName created successfully");
        // return Future.value(true);
      },
    ).catchError(
      (error) {
        print("Failed to create group: $error");
        // return Future.value(false);
      },
    );
    // return Future.value(false);
  }
}
