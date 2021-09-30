import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> swapTokensAPI(
    {required String network,
      required String fromContractAddress,
      required String toContractAddress,
      required int amountIn,
      required int gas,
      required String privateKey,
      required int gasPrice,
      required int minOutPercentage}) async {
  final String baseUrl = dotenv.env['BASE_URL'].toString();
  var url = Uri.parse(baseUrl + '/transactions/swapTokens');

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "network" : network,
      "fromContractAddress" : fromContractAddress,
      "toContractAddress" : toContractAddress,
      "privateKey" : privateKey,
      "amountIn" : amountIn,
      "gas" : gas,
      "gasPrice" : gasPrice,
      "minOutPercentage" : minOutPercentage
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
