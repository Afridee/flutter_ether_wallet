import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

  Future<Map> createEthAccountAPI() async{

  final String baseUrl = dotenv.env['BASE_URL'].toString();

  var url = Uri.parse(baseUrl + '/accounts/create');

  var response = await http.post(
      url, headers: {"Content-Type": "application/json"},
      body: jsonEncode({"password": "password"}));

  if(response.statusCode == 200){
    Map account = jsonDecode(response.body);
    return account;
  }else{
    return {
      "error" : response.body
    };
  }

}