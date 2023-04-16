// To parse this JSON data, do
//
//     final sendData = sendDataFromJson(jsonString);

import 'dart:convert';

SendData sendDataFromJson(String str) => SendData.fromJson(json.decode(str));

String sendDataToJson(SendData data) => json.encode(data.toJson());

class SendData {
  SendData({
    required this.orderId,
    required this.status,
    required this.data,
  });

  String orderId;
  bool status;
  List<Item_details> data;

  factory SendData.fromJson(Map<String, dynamic> json) => SendData(
        orderId: json["order_id"],
        status: json["status"],
        data: List<Item_details>.from(
            json["data"].map((x) => Item_details.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Item_details {
  Item_details({
    required this.productCode,
    required this.poses,
    required this.status,
    required this.comments,
    this.audioComment,
  });

  String productCode;
  List<String> poses;
  bool status;
  String comments;
  String? audioComment;

  factory Item_details.fromJson(Map<String, dynamic> json) => Item_details(
        productCode: json["product_code"],
        poses: List<String>.from(json["poses"].map((x) => x)),
        status: json["status"],
        comments: json["comments"],
        audioComment: json["audio_comment"],
      );

  Map<String, dynamic> toJson() => {
        "product_code": productCode,
        "poses": List<dynamic>.from(poses.map((x) => x)),
        "status": status,
        "comments": comments,
        "audio_comment": audioComment,
      };
}
