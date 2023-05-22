import 'package:choresmate/controller/firebase_controller.dart';

class MyProfileController {
  static Future<String> getUserName() async {
    final snapshot = await FirebaseController.currentUserRef.get();
    final username = snapshot.data()?["username"];
    return username ?? ''; // Provide default value if username is null
  }

  static Future<String> getCurrentEmail() async {
    final snapshot = await FirebaseController.currentUserRef.get();
    final email = snapshot.data()?["email"];
    return email ?? ''; // Provide default value if email is null
  }


  static Future<String> getPhoneNumber() async {
    final snapshot = await FirebaseController.currentUserRef.get();
    final phoneNumber = snapshot.data()?["phoneNumber"];
    return phoneNumber ?? ''; // Provide default value if phoneNumber is null
  }


  static Future<String> getDateOfBirth() async {
    final snapshot = await FirebaseController.currentUserRef.get();
    final dateOfBirth = snapshot.data()?["dateOfBirth"];
    return dateOfBirth ?? ''; // Provide default value if dateOfBirth is null
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
