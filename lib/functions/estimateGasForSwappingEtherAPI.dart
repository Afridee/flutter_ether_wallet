import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> estimateGasForSwappingEtherAPI(
    {required String network,
      required String amountOutMin,
      required String tokenAddress,
      required String value,
      required String admin,
    }) async {
  final String baseUrl = dotenv.env['BASE_URL'].toString();
  var url = Uri.parse(baseUrl + '/estimations/estimateGasForSwappingEther');

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "network" : network,
      "amountOutMin" : amountOutMin,
      "tokenAddress" : tokenAddress,
      "value" : value,
      "admin" : admin
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
