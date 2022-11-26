import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'bluetooth_ble_method_channel.dart';

abstract class BluetoothBlePlatform extends PlatformInterface {
  /// Constructs a BluetoothBlePlatform.
  BluetoothBlePlatform() : super(token: _token);

  static final Object _token = Object();

  static BluetoothBlePlatform _instance = MethodChannelBluetoothBle();
  static BluetoothBlePlatform get instance => _instance;

  static set instance(BluetoothBlePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getBeacon() {
    throw UnimplementedError('getBeacon() has not been implemented.');
  }
}
