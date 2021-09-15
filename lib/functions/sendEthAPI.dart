import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> sendEthAPI(
    {required String network,
    required String fromAddress,
    required String toAddress,
    required int value,
    required int gas,
    required String fromAddressPrivateKey,
    required int gasPrice}) async {
  final String baseUrl = dotenv.env['BASE_URL'].toString();
  var url = Uri.parse(baseUrl + '/transactions/sendEth');

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "network": network,
      "fromAddress": fromAddress,
      "toAddress": toAddress,
      "value": value, //in ether
      "gas": gas,
      "fromAddressPrivateKey": fromAddressPrivateKey,
      "gasPrice": gasPrice //in gwei
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
