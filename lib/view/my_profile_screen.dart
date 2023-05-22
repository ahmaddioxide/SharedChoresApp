import 'package:flutter/material.dart';
import '../controller/myprofile_controller.dart';

import '../ui-components/appbar_for_blue_background.dart';
import '../ui-components/blue_text.dart';
import '../ui-components/custom_button.dart';
import '../ui-components/theme.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    setState(() {
      _isLoading = true;
    });

    final name = await MyProfileController.getUserName();
    final email = await MyProfileController.getCurrentEmail();
    final phoneNumber = await MyProfileController.getPhoneNumber();
    final dateOfBirth = await MyProfileController.getDateOfBirth();

    setState(() {
      _isLoading = false;
      _nameController.text = name.toString();
      _phoneController.text = phoneNumber != null ? phoneNumber.toString() : '';
      _dateController.text = dateOfBirth != null ? dateOfBirth.toString() : '';
      _emailController.text = email.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColorSwatch.pimary,
      appBar: const WhiteAppBar(
        title: "My Profile",
        enableBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CircleAvatar(
                      backgroundImage: const NetworkImage(
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                      radius: MediaQuery.of(context).size.height * 0.07,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const BlueText(text: "Name", fontSize: 12),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                hintText: 'No Name',
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            const BlueText(text: "Email", fontSize: 12),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            TextFormField(
                              controller: _emailController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                hintText: 'No Email',
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            const BlueText(
                                text: "Phone Number", fontSize: 12),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                hintText: 'No Phone Number',
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            const BlueText(text: "No Age Yet", fontSize: 12),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _dateController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                hintText: 'No Age Yet',
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            BlueButton(
                              width: MediaQuery.of(context).size.width * 0.9,
                              buttonText: "Save",
                              onPressed: () async {
                                if (_nameController.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Name is Empty"),
                                    ),
                                  );
                                  return;
                                }
                                setState(() {
                                  _isLoading = true;
                                });

                                await MyProfileController.updateUser(
                                  _nameController.text.trim(),
                                  _phoneController.text.trim(),
                                  _dateController.text.trim(),
                                ).then((value) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                            if (_isLoading)
                              const SizedBox(height: 20),
                            if (_isLoading)
                              const Center(child: CircularProgressIndicator()),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                          ],
                        ),
                      ),
                    )
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


