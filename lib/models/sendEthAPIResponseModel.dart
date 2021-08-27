// To parse this JSON data, do
//
//     final sendEthApiResponseModel = sendEthApiResponseModelFromJson(jsonString);

import 'dart:convert';

SendEthApiResponseModel sendEthApiResponseModelFromJson(String str) => SendEthApiResponseModel.fromJson(json.decode(str));

String sendEthApiResponseModelToJson(SendEthApiResponseModel data) => json.encode(data.toJson());

class SendEthApiResponseModel {
  SendEthApiResponseModel({
    required this.transactionHash,
    required this.rec,
  });

  String transactionHash;
  Rec rec;

  factory SendEthApiResponseModel.fromJson(Map<String, dynamic> json) => SendEthApiResponseModel(
    transactionHash: json["transactionHash"],
    rec: Rec.fromJson(json["rec"]),
  );

  Map<String, dynamic> toJson() => {
    "transactionHash": transactionHash,
    "rec": rec.toJson(),
  };
}

class Rec {
  Rec({
    required this.blockHash,
    required this.blockNumber,
    this.contractAddress,
    required this.cumulativeGasUsed,
    required this.effectiveGasPrice,
    required this.from,
    required this.gasUsed,
    required this.logs,
    required this.logsBloom,
    required this.status,
    required this.to,
    required this.transactionHash,
    required this.transactionIndex,
    required this.type,
  });

  String blockHash;
  int blockNumber;
  dynamic contractAddress;
  int cumulativeGasUsed;
  String effectiveGasPrice;
  String from;
  int gasUsed;
  List<dynamic> logs;
  String logsBloom;
  bool status;
  String to;
  String transactionHash;
  int transactionIndex;
  String type;

  factory Rec.fromJson(Map<String, dynamic> json) => Rec(
    blockHash: json["blockHash"],
    blockNumber: json["blockNumber"],
    contractAddress: json["contractAddress"],
    cumulativeGasUsed: json["cumulativeGasUsed"],
    effectiveGasPrice: json["effectiveGasPrice"],
    from: json["from"],
    gasUsed: json["gasUsed"],
    logs: List<dynamic>.from(json["logs"].map((x) => x)),
    logsBloom: json["logsBloom"],
    status: json["status"],
    to: json["to"],
    transactionHash: json["transactionHash"],
    transactionIndex: json["transactionIndex"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "blockHash": blockHash,
    "blockNumber": blockNumber,
    "contractAddress": contractAddress,
    "cumulativeGasUsed": cumulativeGasUsed,
    "effectiveGasPrice": effectiveGasPrice,
    "from": from,
    "gasUsed": gasUsed,
    "logs": List<dynamic>.from(logs.map((x) => x)),
    "logsBloom": logsBloom,
    "status": status,
    "to": to,
    "transactionHash": transactionHash,
    "transactionIndex": transactionIndex,
    "type": type,
  };
}
