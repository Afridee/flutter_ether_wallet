import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';

final pageList = [
  PageModel(
    color: const Color(0xFFE6E6E6),
    heroImagePath: 'assets/images/ic_launcher.png',
    title: Text('Walleth',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.grey,
          fontSize: 34.0,
        )),
    body: Text('An app made to explore\nthe ethereum blockchain.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 18.0,
        )),
    icon: Icon(
      SimpleIcons.ethereum,
      color: Colors.grey,
    ),
  ),
  PageModel(
    color: const Color(0xFFE6E6E6),
    heroImagePath: 'assets/images/doge-computer.png',
    title: Text('Easy\nManagement',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.grey,
          fontSize: 34.0,
        )),
    body: Text('Handle your eth accounts and\nkeep track of transactions\nwith ease.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 18.0,
        )),
    icon: Icon(
      SimpleIcons.ethereum,
      color: Colors.grey,
    ),
  ),
  PageModel(
    color: const Color(0xFFE6E6E6),
    heroImagePath: 'assets/images/developers-eth-blocks.png',
    title: Text('Operations',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.grey,
          fontSize: 34.0,
        )),
    body: Text('Conduct various types of\neth operations like\nsending and swapping.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 18.0,
        )),
    icon: Icon(
      SimpleIcons.ethereum,
      color: Colors.grey,
    ),
  ),
];
