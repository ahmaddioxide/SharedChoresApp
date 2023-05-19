
import 'package:flutter/material.dart';
import 'package:choresmate/controller/group_chores_controller.dart';
import '../view/chore_details_screen.dart';
import 'blue_text.dart';
import 'theme.dart';

class Chore extends StatefulWidget {
  final String groupID;
  final String title;
  final String choreDescription;
  bool isDone;
  final String choreId;
  final String choreType;
  final String choreDate;
  final String choreTime;

  Chore({
    Key? key,
    required this.groupID,
    required this.title,
    required this.choreDescription,
    required this.isDone,
    required this.choreId,
    required this.choreType,
    required this.choreDate,
    required this.choreTime,
  }) : super(key: key);

  @override
  State<Chore> createState() => _ChoreState();
}

class _ChoreState extends State<Chore> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () {
        setState(() {
          widget.isDone = !widget.isDone;
        });
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChoreDetail(
              choreId: widget.choreId,
              choreName: widget.title,
              choreDescription: widget.choreDescription,
              choreType: widget.choreType,
              choreDate: widget.choreDate,
              choreTime: widget.choreDate,
              isDone: widget.isDone,
            ),
          ),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: CustomColorSwatch.pimary.withOpacity(0.4),
              spreadRadius: 0.3,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.5),
                  ),
                  checkColor: CustomColorSwatch.pimary,
                  value: widget.isDone,
                  onChanged: (value) {
                    GroupChoresController.markChoreAsDone(
                        widget.groupID, widget.choreId)
                        .then((value) {
                      if (value == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Chore marked as done"),
                          ),
                        );
                        setState(() {
                          widget.isDone = value;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Error marking chore as done"),
                          ),
                        );
                      }
                    });
                  },
                ),
              ],
            ),
            BlueText(text: widget.choreDate, fontSize: 14),
          ],
        ),
      ),
    );
  }
}
