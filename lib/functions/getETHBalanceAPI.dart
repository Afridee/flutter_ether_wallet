import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getETHBalanceAPI({required String address, required String network}) async {
  
  Map<String, dynamic> returns;
  
  final String baseUrl = dotenv.env['BASE_URL'].toString();
  var url = Uri.parse(baseUrl + '/accounts/getBalance');

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"address": address, "network": network}),
  );

  if(response.statusCode==200){
    returns = jsonDecode(response.body);
  }else{
    returns = {
      "error" : response.body
    };
  }

  return returns;
}
