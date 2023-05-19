import 'firebase_controller.dart';

class GroupChoresController {
  static Stream<List<Map<String, dynamic>>> getChoresStream(String groupID) {
    return FirebaseController.groupsRef
        .doc(groupID)
        .collection("chores")
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((choreSnapshot) {
        return {
          'choreId': choreSnapshot.id,
          'choreDate': choreSnapshot.data()['choreDate'] ?? '',
          'choreDescription': choreSnapshot.data()['choreDescription'] ?? '',
          'choreName': choreSnapshot.data()['choreName'] ?? '',
          'choreTime': choreSnapshot.data()['choreTime'] ?? '',
          'choreType': choreSnapshot.data()['choreType'] ?? '',
          'isDone': choreSnapshot.data()['isDone'] ?? false,
        };
      }).toList();
    });
  }

  static Future<bool> markChoreAsDone(String groupID, String choreID) {
    FirebaseController.groupsRef
        .doc(groupID)
        .collection("chores")
        .doc(choreID)
        .update({'isDone': true}).then((value) {
      return Future.value(true);
    }).catchError((error) {
      print("Failed to mark chore as done: $error");
      return Future.value(false);
    });
    return Future.value(false);
  }
}
