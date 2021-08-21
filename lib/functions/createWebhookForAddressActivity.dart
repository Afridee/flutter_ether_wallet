import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map> createEthAccountAPI(String appId, String playerId, List<String> ethAddresses) async{

  var url = Uri.parse('https://dashboard.alchemyapi.io/api/create-webhook');

  var response = await http.post(
      url, headers: {"Content-Type": "application/json", "X-Alchemy-Token" : dotenv.env['X_Alchemy_Token'].toString()},
      body: jsonEncode({
        "app_id" : appId,
        "webhook_type" : 4,
        "webhook_url" : "https://afridees-ether-wallet.herokuapp.com/api/notifications/sendNotifications/$playerId",
        "addresses" : ethAddresses
      }));

  Map account = jsonDecode(response.body);

  return account;
}