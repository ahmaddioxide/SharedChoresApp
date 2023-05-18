import 'package:choresmate/controller/create_group_controller.dart';
import 'package:choresmate/ui-components/custom-widgets/black_text.dart';
import 'package:choresmate/ui-components/custom-widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../ui-components/custom-widgets/appbar_for_blue_background.dart';
import '../ui-components/theme.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<String> nameOfMembers = [];
  List<String> userIdsOfMembers = [];

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    final TextEditingController _groupNameController = TextEditingController();
    final TextEditingController _memberEmailController =
        TextEditingController();

    addMember() async {
      List<String> nameAndId = await CreateGroupController.findUserByEmail(
        _memberEmailController.text.trim(),
      );
      userIdsOfMembers.add(nameAndId[1]);
      print(userIdsOfMembers);
      setState(() {
        if (nameAndId[0].isNotEmpty) {
          nameOfMembers.add(nameAndId[0]);
          _memberEmailController.clear();
        }
      });
    }

    createGroup()async{
      if (_groupNameController.text.trim().isEmpty) {
        print("Group Name cannot be empty");
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Group Name cannot be empty")));
      }
      else {
        await CreateGroupController.createGroup(
          _groupNameController.text.trim(),
          userIdsOfMembers,
        ).then((value) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Group Created Successfully")));
        }).onError((error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("There was an error")));
        });
      }
    }

    return Scaffold(
      backgroundColor: CustomColorSwatch.pimary,
      appBar: const WhiteAppBar(
        title: "Create Group",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BlackText(text: "Group Name", fontSize: 24),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    TextField(
                      controller: _groupNameController,
                      decoration: InputDecoration(
                        hintText: "Enter Group Name",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    // SizedBox(
                    //   height: _height * 0.01,
                    // ),
                    const BlackText(text: "Members", fontSize: 24),

                    SizedBox(
                      height: _height * 0.02,
                    ),
                    const Divider(
                      color: CustomColorSwatch.pimary,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: nameOfMembers.length,
                      itemBuilder: (context, index) {
                        return MemberTile(
                            name: nameOfMembers[index].toString());
                      },
                    ),
                    SizedBox(
                      height: _height * 0.02,
                    ),

                    Row(
                      children: [
                        SizedBox(
                          width: _width * 0.77,
                          child: TextField(
                            controller: _memberEmailController,
                            decoration: InputDecoration(
                              hintText: "Email of member",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: _width * 0.02,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: CustomColorSwatch.pimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                                onPressed: () async {
                                  await addMember();
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ))),
                      ],
                    ),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    BlueButton(
                      onPressed: () async {
                        await createGroup();
                      },
                      buttonText: "Create Group",
                      width: _width * 0.8,
                    ),
                    // groupCreated
                    //     ? Column(
                    //         children: [
                    //           const BlackText(
                    //               text: "Add a Member", fontSize: 20),
                    //           SizedBox(
                    //             height: _height * 0.01,
                    //           ),
                    //           TextFormField(
                    //               style: const TextStyle(
                    //                 color: CustomColorSwatch.pimary,
                    //               ),
                    //               decoration: InputDecoration(
                    //                 hintText: "Enter Email of the person",
                    //                 border: OutlineInputBorder(
                    //                   borderRadius: BorderRadius.circular(8),
                    //                   borderSide: const BorderSide(
                    //                     color: CustomColorSwatch.pimary,
                    //                   ),
                    //                 ),
                    //               )),
                    //           SizedBox(
                    //             height: _height * 0.02,
                    //           ),
                    //           BlueButton(
                    //             onPressed: () {},
                    //             buttonText: "Add Member",
                    //             width: _width * 0.8,
                    //           )
                    //         ],
                    //       )
                    //     : Center(
                    //         child: BlueButton(
                    //           buttonText: "Create Group",
                    //           onPressed: () {
                    //             setState(() {
                    //               CreateGroupController.crateGroup(
                    //                 _groupNameController.text.trim(),
                    //               ).then((value) {
                    //                 if (value) {
                    //                   groupCreated = true;
                    //                   ScaffoldMessenger.of(context)
                    //                       .showSnackBar(
                    //                     const SnackBar(
                    //                       content: Text(
                    //                           "Group Created Successfully"),
                    //                     ),
                    //                   );
                    //                 } else {
                    //                   ScaffoldMessenger.of(context)
                    //                       .showSnackBar(
                    //                     const SnackBar(
                    //                       content:
                    //                           Text("Group Creation Failed"),
                    //                     ),
                    //                   );
                    //                 }
                    //               });
                    //             });
                    //           },
                    //           width: 0.8,
                    //         ),
                    //       ),

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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MemberTile extends StatelessWidget {
  final String name;
  const MemberTile({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
