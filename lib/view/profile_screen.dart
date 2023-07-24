import 'package:choresmate/controller/profile_controller.dart';
import 'package:choresmate/ui-components/theme.dart';
import 'package:flutter/material.dart';
import '../ui-components/appbar_for_blue_background.dart';
import '../ui-components/black_text.dart';
import '../ui-components/blue_text.dart';
import 'login_screen.dart';
import 'my_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  onGoBack() {
    // refreshData();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColorSwatch.pimary,
        appBar: const WhiteAppBar(
          title: "Profile",
          enableBackButton: false,
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.topCenter,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                // height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 1,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height *
                        0.12), // Change this based on the spacing between the card container and the avatar
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.20,
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyProfile()),
                          ).then((value) => setState(() {}));
                        },
                        leading: const Icon(
                          Icons.person_2_rounded,
                          color: CustomColorSwatch.pimary,
                        ),
                        title: const BlackText(
                          text: "My Profile",
                          fontSize: 18,
                        ),
                      ),
                      const ListTile(
                        leading: Icon(
                          Icons.auto_graph_rounded,
                          color: CustomColorSwatch.pimary,
                        ),
                        title: BlackText(
                          text: "Statistics",
                          fontSize: 18,
                        ),
                      ),
                      const ListTile(
                        leading: Icon(
                          Icons.settings_rounded,
                          color: CustomColorSwatch.pimary,
                        ),
                        title: BlackText(
                          text: "Settings",
                          fontSize: 18,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          ProfileController.signOut().then(
                            (value) => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            ),
                          );
                        },
                        leading: const Icon(
                          Icons.logout_rounded,
                          color: CustomColorSwatch.pimary,
                        ),
                        title: const BlackText(
                          text: "Logout",
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const ProfileBadge(),
            ],
          ),
        ));
  }
}

class ProfileBadge extends StatelessWidget {
  const ProfileBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ProfileController.getProfileStream(),
        builder: (context, snapshot) => Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: const BoxDecoration(
                color: CustomColorSwatch.pimary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height *
                            0.07), // Change this based on the spacing between the card container and the avatar
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 0.7,
                          blurRadius: 9,
                          offset:
                              const Offset(0, 4), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.09,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              FutureBuilder(
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return BlueText(
                                        text: snapshot.data.toString(),
                                        fontSize: 16);
                                  }
                                  return const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator());
                                },
                                future: ProfileController.getUserName(),
                              ),
                              // BlueText(text: ProfileController.getUserName(), fontSize: 16),
                              FutureBuilder(
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return BlackText(
                                          text: snapshot.data.toString(),
                                          fontSize: 14);
                                    }
                                    return const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator());
                                  },
                                  future: ProfileController.getUserEmail()),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.05,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.work_history_rounded,
                                  color: CustomColorSwatch.pimary,
                                ),
                                FutureBuilder(
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return BlackText(
                                            text: ":  ${snapshot.data}",
                                            fontSize: 14);
                                      }
                                      return const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator());
                                    },
                                    future:
                                        ProfileController.getChoresCompleted()),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    child: CircleAvatar(
                      backgroundImage: const NetworkImage(
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                      radius: MediaQuery.of(context).size.height * 0.075,
                    ),
                  ),
                ],
              ),
            ));
  }
}
