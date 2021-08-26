// To parse this JSON data, do
//
//     final tokenTransaclitionListModel = tokenTransaclitionListModelFromJson(jsonString);

import 'dart:convert';

TokenTransaclitionListModel tokenTransaclitionListModelFromJson(String str) => TokenTransaclitionListModel.fromJson(json.decode(str));

String tokenTransaclitionListModelToJson(TokenTransaclitionListModel data) => json.encode(data.toJson());

class TokenTransaclitionListModel {
  TokenTransaclitionListModel({
    required this.blockNumber,
    required this.timeStamp,
    required this.hash,
    required this.nonce,
    required this.blockHash,
    required this.from,
    required this.contractAddress,
    required this.to,
    required this.value,
    required this.tokenName,
    required this.tokenSymbol,
    required this.tokenDecimal,
    required this.transactionIndex,
    required this.gas,
    required this.gasPrice,
    required this.gasUsed,
    required this.cumulativeGasUsed,
    required this.input,
    required this.confirmations,
  });

  String blockNumber;
  String timeStamp;
  String hash;
  String nonce;
  String blockHash;
  String from;
  String contractAddress;
  String to;
  String value;
  String tokenName;
  String tokenSymbol;
  String tokenDecimal;
  String transactionIndex;
  String gas;
  String gasPrice;
  String gasUsed;
  String cumulativeGasUsed;
  String input;
  String confirmations;

  factory TokenTransaclitionListModel.fromJson(Map<String, dynamic> json) => TokenTransaclitionListModel(
    blockNumber: json["blockNumber"],
    timeStamp: json["timeStamp"],
    hash: json["hash"],
    nonce: json["nonce"],
    blockHash: json["blockHash"],
    from: json["from"],
    contractAddress: json["contractAddress"],
    to: json["to"],
    value: json["value"],
    tokenName: json["tokenName"],
    tokenSymbol: json["tokenSymbol"],
    tokenDecimal: json["tokenDecimal"],
    transactionIndex: json["transactionIndex"],
    gas: json["gas"],
    gasPrice: json["gasPrice"],
    gasUsed: json["gasUsed"],
    cumulativeGasUsed: json["cumulativeGasUsed"],
    input: json["input"],
    confirmations: json["confirmations"],
  );

  Map<String, dynamic> toJson() => {
    "blockNumber": blockNumber,
    "timeStamp": timeStamp,
    "hash": hash,
    "nonce": nonce,
    "blockHash": blockHash,
    "from": from,
    "contractAddress": contractAddress,
    "to": to,
    "value": value,
    "tokenName": tokenName,
    "tokenSymbol": tokenSymbol,
    "tokenDecimal": tokenDecimal,
    "transactionIndex": transactionIndex,
    "gas": gas,
    "gasPrice": gasPrice,
    "gasUsed": gasUsed,
    "cumulativeGasUsed": cumulativeGasUsed,
    "input": input,
    "confirmations": confirmations,
  };
}
