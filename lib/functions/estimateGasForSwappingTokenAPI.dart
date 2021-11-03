import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> estimateGasForSwappingTokenAPI(
    {required String network,
      required String fromContractAddress,
      required String toContractAddress,
      required String from,
      required double amountIn,
      required int minOutPercentage
    }) async {
  final String baseUrl = dotenv.env['BASE_URL'].toString();
  var url = Uri.parse(baseUrl + '/estimations/estimateGasForSwappingToken');

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "network" : network,
      "fromContractAddress" : fromContractAddress,
      "toContractAddress" : toContractAddress,
      "from" : from,
      "amountIn" : amountIn,
      "minOutPercentage" : minOutPercentage
    }),
  );

   return jsonDecode(response.body);
}
