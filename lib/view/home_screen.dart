import 'package:choresmate/controller/home_controller.dart';
import 'package:choresmate/controller/profile_controller.dart';
import 'package:choresmate/ui-components/custom-widgets/blue_text.dart';
import 'package:choresmate/ui-components/theme.dart';
import 'package:choresmate/view/create_group_screen.dart';
import 'package:flutter/material.dart';

import '../ui-components/custom-widgets/black_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.0),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateGroup()));
        },
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.add),
            Text(
              "Create Group",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _height * 0.07,
            ),
            Text(
                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                style: const TextStyle(
                  fontSize: 14,
                )),
            FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      "Welcome ${snapshot.data}",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator());
                },
                future: ProfileController.getUserName()),
            const Text(
              "Have a nice day!",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: _height * 0.03,
            ),
            const BlackText(
              text: "Groups",
              fontSize: 24,
            ),
            SizedBox(
              height: _height * 0.03,
            ),
            FutureBuilder(
                future: HomeController.getListOfGroups(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if(snapshot.data.isEmpty){
                      return const Center(child: Text("No groups found"));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GroupTile(
                          title: snapshot.data[index],
                        );
                      },
                    );
                  }
                  return const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class GroupTile extends StatelessWidget {
  final String title;
  const GroupTile({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
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
          BlueText(
            text: title,
            fontSize: 18,
          ),
        ],
      ),
    );

  }
}

class Chore extends StatefulWidget {
  final String title;
  bool isDone;

  Chore({
    Key? key,
    required this.title,
    required this.isDone,
  }) : super(key: key);

  @override
  State<Chore> createState() => _ChoreState();
}

class _ChoreState extends State<Chore> {
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
              setState(() {
                widget.isDone = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
