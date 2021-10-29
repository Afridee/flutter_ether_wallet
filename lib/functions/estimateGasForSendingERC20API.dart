import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> estimateGasForSendingERC20API(
    {required String network,
      required String fromAddress,
      required String toAddress,
      required String contractAddress,
      required double amountIn,
}) async {
  final String baseUrl = dotenv.env['BASE_URL'].toString();
  var url = Uri.parse(baseUrl + '/estimations/estimateGasForSendingERC20');

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "network" : network,
      "fromAddress": fromAddress,
      "toAddress" : toAddress,
      "ContractAddress" : contractAddress,
      "amountIn" : amountIn,
    }),
  );

  if(response.statusCode==200){
    return jsonDecode(response.body);
  }else{
    return {
      "error" : response.body
    };
  }
}
