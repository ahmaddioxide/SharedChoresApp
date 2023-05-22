import 'package:choresmate/controller/add_chore_controller.dart';
import 'package:flutter/material.dart';
import '../ui-components/appbar_for_blue_background.dart';
import '../ui-components/blue_text.dart';
import '../ui-components/custom_button.dart';
import '../ui-components/theme.dart';
import 'package:intl/intl.dart';

class AddChore extends StatefulWidget {
  final String groupId;
  const AddChore({
    Key? key,
    required this.groupId,
  }) : super(key: key);

  @override
  State<AddChore> createState() => _AddChoreState();
}

class _AddChoreState extends State<AddChore> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  AddChoreController addChoreController = AddChoreController();
  static final DateTime _now = DateTime.now();
  static final DateFormat _formatter = DateFormat('yyyy-MM-dd');
  final String _formattedDate = _formatter.format(_now);
  final String _choreTime = TimeOfDay.now().toString();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    addChore() async {
      if (_titleController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: BlueText(
              text: "Please enter a title",
              fontSize: 12,
            ),
          ),
        );
        return;
      }
      await addChoreController.addChore(
        widget.groupId,
        _titleController.text.trim(),
        _descriptionController.text.trim(),
        _formattedDate,
        _choreTime,
      ).then((value) {
        if (value == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: BlueText(
                text: "Chore added successfully",
                fontSize: 12,
              ),
            ),
          );
        }
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: BlueText(
              text: "Error adding chore",
              fontSize: 12,
            ),
          ),
        );
      });
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: CustomColorSwatch.pimary,
      appBar: const WhiteAppBar(
        title: "Add Chore",
        enableBackButton: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.,
              width: MediaQuery.of(context).size.width * 1,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 16, left: 16, bottom: 30),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BlueText(
                        text: "Title",
                        fontSize: 24,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TextFormField(
                        controller: _titleController,
                        maxLength: 35, // Set the maximum character limit
                        style: const TextStyle(
                          color: CustomColorSwatch.pimary,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter Title",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: CustomColorSwatch.pimary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        '${_titleController.text.length}/35', // Display the character count
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //task type widget selector goes here
                          //weekly and daily
                          InkWell(
                            onTap: () {
                              setState(() {
                                addChoreController.choreTypeSelected = "daily";
                                selectedIndex = 0;
                              });
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.43,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: CustomColorSwatch.pimary,
                                ),
                                color: selectedIndex == 0
                                    ? CustomColorSwatch.pimary
                                    : Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text(
                                  "Weekly",
                                  style: TextStyle(
                                    color: selectedIndex == 0
                                        ? Colors.white
                                        : CustomColorSwatch.pimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                addChoreController.choreTypeSelected = "daily";
                                selectedIndex = 1;
                              });
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.43,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: CustomColorSwatch.pimary,
                                ),
                                color: selectedIndex == 1
                                    ? CustomColorSwatch.pimary
                                    : Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text(
                                  "Daily",
                                  style: TextStyle(
                                    color: selectedIndex == 1
                                        ? Colors.white
                                        : CustomColorSwatch.pimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const BlueText(
                        text: "Description",
                        fontSize: 24,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        maxLength: 150, // Set the maximum character limit
                        style: const TextStyle(
                          color: CustomColorSwatch.pimary,
                        ),
                        decoration: InputDecoration(
                          hintText: "Description of the task",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: CustomColorSwatch.pimary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        '${_descriptionController.text.length}/150', // Display the character count
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const BlueText(
                        text: "Assign To",
                        fontSize: 24,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      const Text("Feature on its way😁, hehe"),

                      // FutureBuilder(
                      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
                      //     if (snapshot.hasData) {
                      //       return ListView.builder(
                      //         shrinkWrap: true,
                      //         itemCount: snapshot.data.length,
                      //         itemBuilder: (context, index) {
                      //           return PersonTile(
                      //             name: snapshot.data[index],
                      //             isSelected: false,
                      //           );
                      //         },
                      //       );
                      //     } else {
                      //       return Center(
                      //         child: Column(
                      //           children: [
                      //             // CircularProgressIndicator(),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             const Text("No Group Members Found"),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             const BlueText(
                      //                 text: "Consider Creating a group?",
                      //                 fontSize: 16),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             BlueButton(
                      //               buttonText: "Create Group",
                      //               onPressed: () {
                      //                 Navigator.of(context).push(
                      //                   MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         const CreateGroup(),
                      //                   ),
                      //                 );
                      //               },
                      //               width:
                      //                   MediaQuery.of(context).size.width * 0.5,
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     }
                      //   },
                      // ),
                      // Expanded(
                      //   child: ListView.builder(
                      //       itemCount: 10,
                      //       itemBuilder: (context, index) {
                      //         return PersonTile(
                      //           name: "Person $index",
                      //           isSelected: false,
                      //         );
                      //       }),
                      // ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      BlueButton(
                        onPressed: () {
                          addChore();
                        },
                        buttonText: "Add Chore",
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class TaskTypeWidget extends StatefulWidget {
//   const TaskTypeWidget({Key? key}) : super(key: key);
//
//   @override
//   State<TaskTypeWidget> createState() => _TaskTypeWidgetState();
// }
//
// class _TaskTypeWidgetState extends State<TaskTypeWidget> {
//   int selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     AddChoreController.choreTypeSelected = "weekly";
//     return
//   }
// }

// class PersonTile extends StatefulWidget {
//   final String name;
//   bool isSelected;
//   PersonTile({
//     Key? key,
//     required this.name,
//     required this.isSelected,
//   }) : super(key: key);
//
//   @override
//   State<PersonTile> createState() => _PersonTileState();
// }
//
// class _PersonTileState extends State<PersonTile> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 5.0),
//       padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5.0),
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: CustomColorSwatch.pimary.withOpacity(0.4),
//             spreadRadius: 0.3,
//             blurRadius: 1,
//             offset: const Offset(1, 1), // changes position of shadow
//           ),
//         ],
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             widget.name,
//             style: const TextStyle(
//               fontSize: 18,
//             ),
//           ),
//           Checkbox(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(4.5),
//             ),
//             checkColor: CustomColorSwatch.pimary,
//             value: widget.isSelected,
//             onChanged: (value) {
//               setState(() {
//                 widget.isSelected = value!;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
