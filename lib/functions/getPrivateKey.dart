import 'dart:convert';
import 'package:ether_wallet_flutter_app/models/EncryptedEthAccountModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getPrivateKeyAPI(
    {required String password,
      required EncryptedEthAccountModel account,
    }) async {
  Map<String, dynamic> returns;

  final String baseUrl = dotenv.env['BASE_URL'].toString();
  var url = Uri.parse(baseUrl + '/accounts/getPrivateKey');

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "password": password,
      "account": account.toJson(),
    }),
  );

  if (response.statusCode == 200) {
    returns = jsonDecode(response.body);
  } else {
    returns = {"error": response.body};
  }

  return returns;
}
