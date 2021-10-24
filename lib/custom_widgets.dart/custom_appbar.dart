import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:ionicons/ionicons.dart';

import '../utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final TextTheme textTheme;
  final String title;
  final ZoomDrawerController drawerController;

  const CustomAppBar({Key? key, required this.textTheme, required this.title, required this.drawerController}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () => drawerController.toggle!(),
        child: Icon(Icons.menu),
      ),
      title: Text(
        title,
        style: textTheme.headline6!.copyWith(color: Colors.white),
      ),
      elevation: 0.0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: Icon(Icons.explore),
        )
      ],
      backgroundColor: kPrimaryColor,
    );
  }
}
