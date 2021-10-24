import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> approveErc20TokenForSwappingAPI(
    {required String network,
      required String tokenAddress,
      required int gas,
      required String privateKey,
      required double gasPrice,
      required String from,
      required String amountIn,
    }) async {
  final String baseUrl = dotenv.env['BASE_URL'].toString();
  var url = Uri.parse(baseUrl + '/transactions/approveErc20TokenForSwapping');

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "network" : network,
      "tokenAddress" : tokenAddress,
      "privateKey" : privateKey,
      "amountIn" : amountIn,
      "gas" : gas,
      "gasPrice" : gasPrice
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
