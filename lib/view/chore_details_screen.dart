import 'package:choresmate/ui-components/black_text.dart';
import 'package:choresmate/ui-components/theme.dart';
import 'package:flutter/material.dart';

import '../ui-components/appbar_for_blue_background.dart';

class ChoreDetail extends StatelessWidget {
  final String choreName;
  final String choreId;
  final String choreDescription;
  final String choreDate;
  final String choreType;
  final String choreTime;
  final bool isDone;
  const ChoreDetail({
    Key? key,
    required this.choreName,
    required this.choreId,
    required this.choreDescription,
    required this.choreDate,
    required this.choreType,
    required this.choreTime,
    required this.isDone,
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
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.task_alt_outlined,
                                    color: CustomColorSwatch.pimary,
                                    size: 32,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  BlackText(
                                    text: choreName,
                                    fontSize: 24,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                choreDescription,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    color: CustomColorSwatch.pimary,
                                    size: 32,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  BlackText(
                                    text: choreDate,
                                    fontSize: 24,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.task_alt_outlined,
                                    color: CustomColorSwatch.pimary,
                                    size: 32,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  BlackText(
                                    text: choreType,
                                    fontSize: 24,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: CustomColorSwatch.pimary,
                                    size: 32,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  BlackText(
                                    text: isDone ? "Done" : "Not Done",
                                    fontSize: 24,
                                  ),
                                ],
                              ),
                            ],
                          ),
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
