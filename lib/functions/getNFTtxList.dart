import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//network value is "-rinkeby" if transactions are in rinkeby network
//otherwise leave it ""...

Future<Map<String, dynamic>> getNFTTransactions(
    {required String network, required String address}) async{
  final String apiKey = dotenv.env['ETHERSCAN_API_KEY'].toString();
  String link = "https://api$network.etherscan.io/api?module=account&action=tokennfttx&address=$address&startblock=0&endblock=latest&sort=asc&apikey=$apiKey";
  var url = Uri.parse(link);

  var response = await http.get(url);

  if(response.statusCode==200){
    return jsonDecode(response.body);
  }else{
    return {
      "error" : response.body
    };
  }
}