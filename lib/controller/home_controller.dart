import 'firebase_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController {
  static Future<List<String>> getListOfGroups() async {
    DocumentSnapshot<Map<String, dynamic>> currentUser =
    await FirebaseController.usersRef
        .doc(FirebaseController.user!.uid)
        .get();

    if (!currentUser.exists || !currentUser.data()!.containsKey("groupIds")) {
      return ["No groups found"];
    } else {
      List<String> groups = List<String>.from(currentUser.data()!["groupIds"]);
      return groups;
    }
  }

  static Stream<dynamic> getGroupsStream() {
    return FirebaseController.usersRef
        .doc(FirebaseController.user!.uid)
        .get()
        .then((currentUser) {
      return FirebaseController.groupsRef
          .doc(currentUser.data()!["groupIds"][0])
          .snapshots();
    }).asStream();
  }

  static Stream<List<String>> getListOfGroupsStream() {
    return FirebaseController.usersRef
        .doc(FirebaseController.user!.uid)
        .snapshots()
        .map((currentUser) {
      if (!currentUser.exists || !currentUser.data()!.containsKey("groupIds")) {
        return ["No groups found"];
      } else {
        List<String> groups = List<String>.from(currentUser.data()!["groupIds"]);
        print("GROUP IDS FROM STREAMS $groups");
        return groups;
      }
    });
  }




}
