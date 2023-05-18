import 'package:choresmate/ui-components/black_text.dart';
import 'package:choresmate/ui-components/theme.dart';
import 'package:flutter/material.dart';

import '../ui-components/appbar_for_blue_background.dart';

class ChoreDetail extends StatelessWidget {
  final String choreName;
  final String choreId;
  const ChoreDetail({
    Key? key,
    required this.choreName,
    required this.choreId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorSwatch.pimary,
      appBar: WhiteAppBar(
        title: "$choreName Details",
        enableBackButton: true,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 1,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height *
                      0.08), // Change this based on the spacing between the card container and the avatar
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Column(
                  children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(10),
                      border: Border(
                        left: BorderSide(
                          color: CustomColorSwatch.pimary,
                          width: 5,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child:   Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children:  [
                              const Icon(
                                Icons.task_alt_outlined,
                                color: CustomColorSwatch.pimary,
                                size: 32,
                              ),
                              const SizedBox(width: 10,),
                              BlackText(text: choreName, fontSize: 24,),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          const Text("user interface (UI) is anything a user may interact with to use a digital product or service. This includes everything from screens and touchscreens, keyboards, sounds, and even lights. To understand the evolution of UI, however, it’s helpful to learn a bit more about its history and how it has evolved into best practices and a profession.", style: TextStyle(fontSize: 16),),
                        ],
                      ),

                    ),
                  ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
