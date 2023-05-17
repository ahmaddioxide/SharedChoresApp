import 'package:choresmate/ui-components/custom-widgets/appbar_for_blue_background.dart';
import 'package:choresmate/ui-components/custom-widgets/custom_button.dart';
import 'package:flutter/material.dart';
import '../controller/add_chore_controller.dart';
import '../ui-components/custom-widgets/blue_text.dart';
import '../ui-components/theme.dart';
import 'create_group_screen.dart';

class AddChore extends StatefulWidget {
  const AddChore({Key? key}) : super(key: key);

  @override
  State<AddChore> createState() => _AddChoreState();
}

class _AddChoreState extends State<AddChore> {
  @override
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    // final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColorSwatch.pimary,
      appBar: const WhiteAppBar(
        title: "Add Chore",
        enableBackButton: true,
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                print(await AddChoreController.getUserGroupId());
                // await AddChoreController.getUserGroupId();
              },
              child: const Text("Display emails")),
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
                    const BlueText(
                      text: "Title",
                      fontSize: 24,
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    TextFormField(
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
                        )),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    const TaskTypeWidget(),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    const BlueText(
                      text: "Description",
                      fontSize: 24,
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    TextFormField(
                        maxLines: 3,
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
                        )),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    const BlueText(
                      text: "Assign To",
                      fontSize: 24,
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),

                    FutureBuilder(
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return PersonTile(
                                name: snapshot.data[index],
                                isSelected: false,
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Column(
                              children: [
                                // CircularProgressIndicator(),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("No Group Members Found"),
                                const SizedBox(
                                  height: 10,
                                ),
                                const BlueText(
                                    text: "Consider Creating a group?",
                                    fontSize: 16),
                                const SizedBox(
                                  height: 10,
                                ),
                                BlueButton(
                                  buttonText: "Create Group",
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CreateGroup(),
                                      ),
                                    );
                                  },
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
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

class TaskTypeWidget extends StatefulWidget {
  const TaskTypeWidget({Key? key}) : super(key: key);

  @override
  State<TaskTypeWidget> createState() => _TaskTypeWidgetState();
}

class _TaskTypeWidgetState extends State<TaskTypeWidget> {
  int SelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //task type widget selector goes here
        //weekly and daily
        InkWell(
          onTap: () {
            setState(() {
              SelectedIndex = 0;
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.43,
            decoration: BoxDecoration(
              border: Border.all(
                color: CustomColorSwatch.pimary,
              ),
              color:
                  SelectedIndex == 0 ? CustomColorSwatch.pimary : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Text(
                "Weekly",
                style: TextStyle(
                  color: SelectedIndex == 0
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
              SelectedIndex = 1;
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.43,
            decoration: BoxDecoration(
              border: Border.all(
                color: CustomColorSwatch.pimary,
              ),
              color:
                  SelectedIndex == 1 ? CustomColorSwatch.pimary : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Text(
                "Daily",
                style: TextStyle(
                  color: SelectedIndex == 1
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
    );
  }
}

class PersonTile extends StatefulWidget {
  final String name;
  bool isSelected;
  PersonTile({
    Key? key,
    required this.name,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<PersonTile> createState() => _PersonTileState();
}

class _PersonTileState extends State<PersonTile> {
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
            widget.name,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            checkColor: CustomColorSwatch.pimary,
            value: widget.isSelected,
            onChanged: (value) {
              setState(() {
                widget.isSelected = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
