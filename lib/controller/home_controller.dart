import 'firebase_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController {
  static Future<List<String>> getListOfGroups() async {
    DocumentSnapshot<Map<String, dynamic>> currentUser =
        await FirebaseController.usersRef
            .doc(FirebaseController.user!.uid)
            .get();
    if (!currentUser.toString().contains("groupIds")) {
      return Future.value(["No groups found"]);
    } else {
      var groups = currentUser["groupIds"];
      return Future.value(groups);
    }
  }
}
