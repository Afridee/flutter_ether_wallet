import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'HomePage.dart';
import 'MenuScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final drawerController = ZoomDrawerController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        controller: drawerController,
        style: DrawerStyle.DefaultStyle,
        menuScreen: MenuScreen(),
        mainScreen: HomeScreen(drawerController: drawerController,),
        borderRadius: 24.0,
        showShadow: true,
        angle: -12.0,
        backgroundColor: Colors.grey,
        slideWidth: MediaQuery.of(context).size.width*.65,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
      ),
    );
  }
}
