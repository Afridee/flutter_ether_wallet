import '../utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final TextTheme textTheme;
  final String title;

  const CustomAppBar({Key? key, required this.textTheme, required this.title}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'itmar.argent.xyz',
        style: textTheme.headline6!.copyWith(color: Colors.white),
      ),
      elevation: 0.0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: Icon(CupertinoIcons.qrcode),
        )
      ],
      backgroundColor: kPrimaryColor,
    );
  }
}
