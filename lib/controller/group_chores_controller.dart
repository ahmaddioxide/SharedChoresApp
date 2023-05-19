
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
          'choreDate': choreSnapshot.data()['choreDate'] ?? '',
          'choreDescription': choreSnapshot.data()['choreDescription'] ?? '',
          'choreName': choreSnapshot.data()['choreName'] ?? '',
          'choreTime': choreSnapshot.data()['choreTime'] ?? '',
          'choreType': choreSnapshot.data()['choreType'] ?? '',
        };
      }).toList();
    });
  }








}
