import 'package:choresmate/controller/firebase_controller.dart';

class ProfileController {
  static Future<String> getUserName() async {
    final currentUser = await FirebaseController.currentUserRef.get();
    print(await currentUser.data()!["username"]);
    return currentUser.data()!["username"] ?? "No username";
  }

  static Future<String> getProfession() async {
    final currentUser = await FirebaseController.currentUserRef.get();
    print(await currentUser.data()!["profession"]);
    return currentUser.data()!["profession"] ?? "No profession";
  }

  static Future<String> getUserEmail() async {
    final currentUser = await FirebaseController.currentUserRef.get();
    print(await currentUser.data()!["email"]);
    return currentUser.data()!["email"] ?? "No email";
  }

  static Future<String> getChoresCompleted() async {
    final currentUser = await FirebaseController.currentUserRef.get();
    print(await currentUser.data()!["choresCompleted"]);
    return currentUser.data()!["choresCompleted"] ?? "No chores completed";
  }

  static Future<bool> signOut() async {
    try {
      await FirebaseController.auth.signOut();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
