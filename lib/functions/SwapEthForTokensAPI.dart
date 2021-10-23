import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> swapEthForTokensAPI(
    {required String network,
    required String privateKey,
    required String tokenAddress,
    required double amountOutMin,
    required String gas,
    required String value,
    required String gasPrice}) async {
  final String baseUrl = dotenv.env['BASE_URL'].toString();
  var url = Uri.parse(baseUrl + '/transactions/SwapEthForTokens');

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "network": network,
      "amountOutMin": amountOutMin,
      "tokenAddress": tokenAddress,
      "privateKey": privateKey,
      "gas": gas,
      "gasPrice": gasPrice,
      "value": value
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return {"error": response.body};
  }
}
