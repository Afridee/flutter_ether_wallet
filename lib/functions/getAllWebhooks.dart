import 'dart:convert';
import 'package:ether_wallet_flutter_app/models/WebhooksModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<List<Datum>> getAllWebhooks() async {
  print("pressed");
  List<Datum> webhooks = [];
  var url = Uri.parse("https://dashboard.alchemyapi.io/api/team-webhooks");
  var response = await http.get(url,
      headers: {"X-Alchemy-Token": dotenv.env['X_Alchemy_Token'].toString()});

  if (response.statusCode == 200) {
    WebhooksModel model = WebhooksModel.fromJson(jsonDecode(response.body));

    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;

    if (osUserID != null) {
      model.data.forEach((element) {
        if (element.webhookUrl.contains(osUserID)) webhooks.add(element);
      });
    }
  }

  return webhooks;
}
