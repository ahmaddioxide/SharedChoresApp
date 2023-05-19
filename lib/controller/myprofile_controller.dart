import 'package:choresmate/controller/firebase_controller.dart';

class MyProfileController {
  static Future<String> getUserName() async {
    return FirebaseController.currentUserRef.get().then(
          (value) => value.data()!["username"],
        );
  }

  static Future<String> getCurrentEmail() async {
    return await FirebaseController.currentUserRef.get().then(
          (value) => value.data()!["email"],
        );
  }

  static Future<String> getPhoneNumber() async {
    return await FirebaseController.currentUserRef.get().then(
          (value) => value.data()!["phoneNumber"],
        );
  }

  static Future<String> getDateOfBirth() async {
    return await FirebaseController.currentUserRef
        .get()
        .then((value) => value.data()!["dateOfBirth"]);
  }

  static Future<void> updateUserName(String username) async {
    await FirebaseController.currentUserRef.update(
      {"username": username},
    );
  }

  static Future<void> updatePhoneNumber(String phoneNumber) async {
    await FirebaseController.currentUserRef.update(
      {"phoneNumber": phoneNumber},
    );
  }

  static Future<void> updateDateOfBirth(String dateOfBirth) async {
    await FirebaseController.currentUserRef.update(
      {"dateOfBirth": dateOfBirth},
    );
  }

  static Future<void> updateUser(
      String username, String phoneNumber, String dateOfBirth) async {
    await FirebaseController.currentUserRef.update(
      {
        "username": username,
        "phoneNumber": phoneNumber,
        "dateOfBirth": dateOfBirth,
      },
    );
  }
}
