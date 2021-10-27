import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> swapTokensForEthAPI(
    {
      required String network,
      required String fromContractAddress,
      required double amountIn,
      required int gas,
      required String privateKey,
      required double gasPrice,
      required int minOutPercentage
    }) async {
  final String baseUrl = dotenv.env['BASE_URL'].toString();
  var url = Uri.parse(baseUrl + '/transactions/swapTokensForEth');

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "network" : network,
      "fromContractAddress" : fromContractAddress,
      "privateKey" : privateKey,
      "amountIn" : amountIn,
      "gas" : gas,
      "gasPrice" : gasPrice,
      "minOutPercentage" : minOutPercentage
    }),
  );
  print(response.body);

  return jsonDecode(response.body);
}
