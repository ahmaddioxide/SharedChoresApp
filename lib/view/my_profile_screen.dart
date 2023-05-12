import 'package:choresmate/ui-components/custom-widgets/appbar_for_blue_background.dart';
import 'package:flutter/material.dart';

import '../ui-components/theme.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
