import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> sendErc20API(
    {required String network,
      required String fromAddress,
      required String toAddress,
      required String contractAddress,
      required double amountIn,
      required int gas,
      required String fromAddressPrivateKey,
      required double gasPrice}) async {
  final String baseUrl = dotenv.env['BASE_URL'].toString();
  var url = Uri.parse(baseUrl + '/transactions/sendErc20');

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "network" : network,
      "fromAddress": fromAddress,
      "toAddress" : toAddress,
      "ContractAddress" : contractAddress,
      "amountIn" : amountIn,
      "gas" : gas,
      "fromAddressPrivateKey" : fromAddressPrivateKey,
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
