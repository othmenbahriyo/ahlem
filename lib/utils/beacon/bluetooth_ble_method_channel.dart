import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bluetooth_ble_platform_interface.dart';

class MethodChannelBluetoothBle extends BluetoothBlePlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('bluetooth_ble');

  @override
  Future<String?> getBeacon() async {
    final beacon = await methodChannel.invokeMethod<String>('getBeacon');
    return beacon;
  }
}
