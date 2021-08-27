// To parse this JSON data, do
//
//     final transactionDetailsModel = transactionDetailsModelFromJson(jsonString);

import 'dart:convert';

TransactionDetailsModel transactionDetailsModelFromJson(String str) => TransactionDetailsModel.fromJson(json.decode(str));

String transactionDetailsModelToJson(TransactionDetailsModel data) => json.encode(data.toJson());

class TransactionDetailsModel {
  TransactionDetailsModel({
    required this.transactionDetails,
  });

  TransactionDetails transactionDetails;

  factory TransactionDetailsModel.fromJson(Map<String, dynamic> json) => TransactionDetailsModel(
    transactionDetails: TransactionDetails.fromJson(json["transactionDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "transactionDetails": transactionDetails.toJson(),
  };
}

class TransactionDetails {
  TransactionDetails({
    required this.hash,
    required this.blockHash,
    required this.blockNumber,
    required this.from,
    required this.gas,
    required this.gasPrice,
    required this.input,
    required this.nonce,
    required this.r,
    required this.s,
    required this.to,
    required this.transactionIndex,
    required this.type,
    required this.v,
    required this.value,
  });

  String hash;
  String blockHash;
  int blockNumber;
  String from;
  int gas;
  String gasPrice;
  String input;
  int nonce;
  String r;
  String s;
  String to;
  int transactionIndex;
  int type;
  String v;
  String value;

  factory TransactionDetails.fromJson(Map<String, dynamic> json) => TransactionDetails(
    hash: json["hash"],
    blockHash: json["blockHash"],
    blockNumber: json["blockNumber"],
    from: json["from"],
    gas: json["gas"],
    gasPrice: json["gasPrice"],
    input: json["input"],
    nonce: json["nonce"],
    r: json["r"],
    s: json["s"],
    to: json["to"],
    transactionIndex: json["transactionIndex"],
    type: json["type"],
    v: json["v"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "hash": hash,
    "blockHash": blockHash,
    "blockNumber": blockNumber,
    "from": from,
    "gas": gas,
    "gasPrice": gasPrice,
    "input": input,
    "nonce": nonce,
    "r": r,
    "s": s,
    "to": to,
    "transactionIndex": transactionIndex,
    "type": type,
    "v": v,
    "value": value,
  };
}
