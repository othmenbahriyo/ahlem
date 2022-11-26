
import 'bluetooth_ble_platform_interface.dart';

class BluetoothBle {
  Future<String?> getBeacon() {
    return BluetoothBlePlatform.instance.getBeacon();
  }
}
