import 'dart:io';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'Screens/LoginPage.dart';
import 'Screens/OnboardingScreen/onboardingScreen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Directory Document = await getApplicationDocumentsDirectory();
  Hive.init(Document.path);
  await Hive.openBox<Map>('userObj');
  await Hive.openBox<String>('ERC20Tokens');
  await Firebase.initializeApp();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId(dotenv.env['ONESIGNAL_APP_ID'].toString());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Onboardinscreen(),
    );
  }
}

class Onboardinscreen extends StatefulWidget {
  const Onboardinscreen({Key? key}) : super(key: key);

  @override
  _OnboardinscreenState createState() => _OnboardinscreenState();
}

class _OnboardinscreenState extends State<Onboardinscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Pass pageList and the mainPage route.
      body: FancyOnBoarding(
         skipButtonTextStyle: TextStyle(
           color: Colors.grey,
           fontWeight: FontWeight.bold,
           fontSize: 15
         ),
        doneButtonBackgroundColor: Colors.grey,
        doneButtonText: "Done",
        skipButtonText: "Skip",
        pageList: pageList,
        onDoneButtonPressed: () =>
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new LoginPage(),
              ),
            ),
        onSkipButtonPressed: () =>
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new LoginPage(),
              ),
            ),
      ),
    );
  }
}


