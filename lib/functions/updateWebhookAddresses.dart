import 'dart:convert';
import 'package:ether_wallet_flutter_app/models/WebhooksModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

updateWebhookAddresses(int webhookId, List<String> addresses) async {
  var url = Uri.parse("https://dashboard.alchemyapi.io/api/update-webhook-addresses");
  var response = await http.put(url,
      headers: {"X-Alchemy-Token": dotenv.env['X_Alchemy_Token'].toString()},
      body: jsonEncode({"webhook_id": webhookId, "addresses" : addresses}));
}
