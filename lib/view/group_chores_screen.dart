import 'package:flutter/material.dart';
import 'package:choresmate/controller/group_chores_controller.dart';
import 'package:choresmate/ui-components/black_text.dart';
import 'package:choresmate/ui-components/blue_text.dart';
import 'package:choresmate/ui-components/transparent_appbar.dart';
import 'package:choresmate/view/add_chore_screen.dart';
import 'package:choresmate/ui-components/chore_tile.dart';


class GroupChores extends StatefulWidget {
  final String groupId;
  const GroupChores({
    Key? key,
    required this.groupId,
  }) : super(key: key);

  @override
  State<GroupChores> createState() => _GroupChoresState();
}

class _GroupChoresState extends State<GroupChores> {
  final dayOfWeek = DateTime.now().weekday;
  static const Map<int, String> weekdayName = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday"
  };
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddChore(
                groupId: widget.groupId,
              ),
            ),
          );
        },
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.add),
            Text(
              "Add Chore",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.0),
        ),
      ),
      appBar: const BlueAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const BlackText(text: "Tasks of : ", fontSize: 20),
                SizedBox(
                  width: width * 0.008,
                ),
                BlueText(
                  text: weekdayName[DateTime.now().weekday]!,
                  fontSize: 20,
                )
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: GroupChoresController.getChoresStream(widget.groupId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final chores = snapshot.data;
                  if (chores != null && chores.isEmpty) {
                    return const Center(
                      child: BlueText(
                        text: "No chores found",
                        fontSize: 18,
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: chores?.length ?? 0,
                      itemBuilder: (context, index) {
                        final chore = chores![index];
                        return Chore(
                          groupID: widget.groupId,
                          title: chore['choreName'],
                          isDone: chore['isDone'] ?? false,
                          choreId: chore['choreId'],
                          choreDescription: chore['choreDescription'],
                          choreType: chore['choreType'],
                          choreDate: chore['choreDate'],
                          choreTime: chore['choreTime'],
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

