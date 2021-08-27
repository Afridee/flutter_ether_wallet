// To parse this JSON data, do
//
//     final nftTransaclitionListModel = nftTransaclitionListModelFromJson(jsonString);

import 'dart:convert';

NftTransaclitionListModel nftTransaclitionListModelFromJson(String str) => NftTransaclitionListModel.fromJson(json.decode(str));

String nftTransaclitionListModelToJson(NftTransaclitionListModel data) => json.encode(data.toJson());

class NftTransaclitionListModel {
  NftTransaclitionListModel({
    required this.blockNumber,
    required this.timeStamp,
    required this.hash,
    required this.nonce,
    required this.blockHash,
    required this.from,
    required this.contractAddress,
    required this.to,
    required this.tokenId,
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
  String tokenId;
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

  factory NftTransaclitionListModel.fromJson(Map<String, dynamic> json) => NftTransaclitionListModel(
    blockNumber: json["blockNumber"],
    timeStamp: json["timeStamp"],
    hash: json["hash"],
    nonce: json["nonce"],
    blockHash: json["blockHash"],
    from: json["from"],
    contractAddress: json["contractAddress"],
    to: json["to"],
    tokenId: json["tokenID"],
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
    "tokenID": tokenId,
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
