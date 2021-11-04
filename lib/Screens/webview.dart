import 'package:ether_wallet_flutter_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/route_manager.dart';

class MyInAppBrowser extends InAppBrowser {
  @override
  Future onBrowserCreated() async {
    //print("Browser Created!");
  }

  @override
  Future onLoadStart(url) async {
    //print("Started $url");
  }

  @override
  Future onLoadStop(url) async {
    //print("Stopped $url");
  }

  @override
  void onLoadError(url, code, message) {
    //print("Can't load $url.. Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    //print("Progress: $progress");
  }

  @override
  void onExit() {
    //print("Browser closed!");
  }

}



class Webview extends StatefulWidget {

  final String link;

  const Webview({Key? key, required this.link}) : super(key: key);



  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {

  final MyInAppBrowser browser = new MyInAppBrowser();

  var options = InAppBrowserClassOptions(
      android: AndroidInAppBrowserOptions(allowGoBackWithBackButton: true),
      crossPlatform: InAppBrowserOptions(hideUrlBar: false),
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)));

  @override
  void initState() {
    browser.openUrlRequest(
        urlRequest: URLRequest(url: Uri.parse(widget.link)),
        options: options);
    super.initState();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(widget.link.toString(), style: TextStyle(
          fontSize: 15
        ),),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(),
      ),
    );
  }
}