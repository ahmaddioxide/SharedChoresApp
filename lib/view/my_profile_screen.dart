import 'package:choresmate/ui-components/custom-widgets/appbar_for_blue_background.dart';
import 'package:choresmate/ui-components/custom-widgets/blue_text.dart';
import 'package:choresmate/view/profile_screen.dart';
import 'package:flutter/material.dart';

import '../controller/myprofile_controller.dart';
import '../ui-components/custom-widgets/custom_button.dart';
import '../ui-components/theme.dart';

class MyProfile extends StatefulWidget {
  final VoidCallback? onClose;
  const MyProfile({Key? key,this.onClose}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorSwatch.pimary,
      appBar: const WhiteAppBar(
        title: "My Profile",
        enableBackButton: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 1,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(
                    child: CircleAvatar(
                      backgroundImage: const NetworkImage(
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                      radius: MediaQuery.of(context).size.height * 0.07,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BlueText(text: "Name", fontSize: 12),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        FutureBuilder(
                            future: MyProfileController.getUserName(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              _nameController.text = snapshot.data.toString();
                              return TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  hintText: snapshot.hasData
                                      ? snapshot.data.toString()
                                      : 'Name nhi he',
                                ),
                              );
                            }),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        const BlueText(text: "Email", fontSize: 12),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        FutureBuilder(
                            future: MyProfileController.getCurrentEmail(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  hintText: snapshot.hasData
                                      ? snapshot.data.toString()
                                      : 'Email nhi he',
                                ),
                              );
                            }),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        const BlueText(text: "Phone Number", fontSize: 12),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        FutureBuilder(
                            future: MyProfileController.getPhoneNumber(),
                            builder: (context, snapshot) {
                              _phoneController.text = snapshot.data != null
                                  ? snapshot.data.toString()
                                  : "";
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return TextFormField(
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  hintText: snapshot.hasData
                                      ? snapshot.data.toString()
                                      : 'Phone Number nhi he',
                                ),
                              );
                            }),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        const BlueText(text: "Age", fontSize: 12),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        FutureBuilder(
                            future: MyProfileController.getDateOfBirth(),
                            builder: (context, snapshot) {
                              _dateController.text = snapshot.data != null
                                  ? snapshot.data.toString()
                                  : "";
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return TextFormField(
                                controller: _dateController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  hintText: snapshot.hasData
                                      ? snapshot.data.toString()
                                      : 'Age nhi he',
                                ),
                              );
                            }),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        BlueButton(
                          width: MediaQuery.of(context).size.width * 0.9,
                          buttonText: "Save",
                          onPressed: () async {
                            await MyProfileController.updateUser(
                                    _nameController.text.trim(),
                                    _phoneController.text.trim(),
                                    _dateController.text.trim())
                                .then((value) {

                       Navigator.of(context).pop();

                            });

                          },
                        ),
                      ],
                    )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
