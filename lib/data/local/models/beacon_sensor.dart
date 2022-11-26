// To parse this JSON data, do
//
//     final beaconSensor = beaconSensorFromJson(jsonString);

import 'dart:convert';

BeaconSensor beaconSensorFromJson(String str) =>
    BeaconSensor.fromJson(json.decode(str));

String beaconSensorToJson(BeaconSensor data) => json.encode(data.toJson());

class BeaconSensor {
  BeaconSensor({
    this.bluetoothAddress,
    this.bluetoothName,
    // this.distance,
    this.instanceId,
    this.namespaceId,
  });

  String? bluetoothAddress;
  String? bluetoothName;
  // double? distance;
  String? instanceId;
  String? namespaceId;

  factory BeaconSensor.fromJson(Map<String, dynamic> json) => BeaconSensor(
        bluetoothAddress: json["bluetoothAddress"],
        bluetoothName: json["bluetoothName"],
        // distance: json["distance"].toDouble(),
        instanceId: json["instanceId"].toString().substring(2,json["instanceId"].toString().length),
        namespaceId: json["nameSpaceId"].toString().substring(2,json["nameSpaceId"].toString().length),
      );

  Map<String, dynamic> toJson() => {
        "bluetoothAddress": bluetoothAddress,
        "bluetoothName": bluetoothName,
        // "distance": distance,
        "instanceId": instanceId,
        "nameSpaceId": namespaceId,
      };

  @override
  String toString() {
    return 'BeaconSensor{bluetoothAddress: $bluetoothAddress, bluetoothName: $bluetoothName, instanceId: $instanceId, nameSpaceId: $namespaceId}';
  }
}
