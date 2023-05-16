import 'package:choresmate/controller/profile_controller.dart';
import 'package:choresmate/ui-components/theme.dart';
import 'package:flutter/material.dart';

import '../ui-components/custom-widgets/black_text.dart';
import 'add_chore_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton:FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.0),
        ),
        onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AddChore())
          );
        }, label: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.add),
          Text("Add Chore", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        ],
      ),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _height * 0.07,
            ),
            Text("${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
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
              text: "Daily Chores",
              fontSize: 24,
            ),
            SizedBox(
              height: _height * 0.03,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Chore(
                    title: "Chore $index",
                    isDone: false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}


class Chore extends StatefulWidget {
  final String title;
   bool isDone;

   Chore({Key? key,
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
            offset: const Offset(1,1), // changes position of shadow
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

