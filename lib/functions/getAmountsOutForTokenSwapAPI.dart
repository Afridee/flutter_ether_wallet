import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> estimateAmountsOutAPI(
    {required String network,
      required String fromContractAddress,
      required String toContractAddress,
      required String amountIn,
     }) async {
  final String baseUrl = dotenv.env['BASE_URL'].toString();
  var url = Uri.parse(baseUrl + '/estimations/estimateAmountsOut');

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "network" : network,
      "fromContractAddress" : fromContractAddress,
      "toContractAddress" : toContractAddress,
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
