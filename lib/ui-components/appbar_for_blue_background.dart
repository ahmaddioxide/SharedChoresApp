import 'package:flutter/material.dart';
import 'theme.dart';

class WhiteAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool enableBackButton;
  const WhiteAppBar({
    Key? key,
    required this.title,
    this.enableBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: enableBackButton?
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.arrow_back_ios,
              color: CustomColorSwatch.pimary,
            ),
          ),
        ),
      ):null,
      title: title == ""
          ? null
          : Text(
              title,
              style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
            ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
