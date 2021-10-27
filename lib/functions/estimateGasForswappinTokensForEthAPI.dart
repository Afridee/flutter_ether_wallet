import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> estimateGasForswappinTokensForEthAPI(
    {required String network,
      required String address,
      required String fromContractAddress,
      required int minOutPercentage,
      required String amountIn,
    }) async {
  final String baseUrl = dotenv.env['BASE_URL'].toString();
  var url = Uri.parse(baseUrl + '/estimations/estimateGasForswappinTokensForEth');

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "address" : address,
      "network" : network,
      "fromContractAddress" : fromContractAddress,
      "amountIn" : amountIn,
      "minOutPercentage" : minOutPercentage
    }),
  );

  return jsonDecode(response.body);
}
