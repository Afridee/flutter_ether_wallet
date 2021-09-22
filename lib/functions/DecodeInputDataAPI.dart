import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> decodeInputDataAPI(
    {required String inputdata,required List abi}) async {
  final String baseUrl = dotenv.env['BASE_URL'].toString();
  var url = Uri.parse(baseUrl + '/transactions/decodeinputdata');

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "inputdata": inputdata,
      "abi": abi,
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
