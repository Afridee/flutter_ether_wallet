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
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
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

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  late bool onboardingShown = true;

  initiate() async{
    prefs = await _prefs;
    setState(() {
      onboardingShown = prefs.getBool('onboarded') ?? false;
    });
  }

  @override
  void initState() {
    initiate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return onboardingShown? LoginPage() : Scaffold(
      //Pass pageList and the mainPage route.
      body: FancyOnBoarding(
          skipButtonTextStyle: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
          doneButtonBackgroundColor: Colors.grey,
          doneButtonText: "Done",
          skipButtonText: "Skip",
          pageList: pageList,
          onDoneButtonPressed: (){
            prefs.setBool("onboarded", true);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new LoginPage(),
              ),
            );
          },
          onSkipButtonPressed: () {
            prefs.setBool("onboarded", true);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new LoginPage(),
              ),
            );
          }),
    );
  }
}
