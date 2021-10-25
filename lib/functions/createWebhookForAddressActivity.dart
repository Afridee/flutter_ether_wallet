import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map> create_Webhook_ForMinedTransactionNotifications(
    {required String appId,
    required String playerId,
    }) async {
  var url = Uri.parse('https://dashboard.alchemyapi.io/api/create-webhook');
  final String baseUrl = dotenv.env['BASE_URL'].toString();

  var response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "X-Alchemy-Token": dotenv.env['X_Alchemy_Token'].toString()
      },
      body: jsonEncode({
        "app_id": appId,
        "webhook_type": 2,
        "webhook_url": "$baseUrl/notifications/sendNotificationsForAddressActivity/$playerId",
      }));

  Map responsBod = jsonDecode(response.body);

  return responsBod;
}
