import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Model extends ChangeNotifier {
  bool bluetoothEnabled = false;
  BluetoothDevice? device;
  BluetoothConnection? connection;

  void changebluetoothEnabled(value) {
    bluetoothEnabled = value;
    notifyListeners();
  }

  void setBlueDetails(_device, conn) {
    device = _device;
    connection = conn;
    print('device is ${device!.name} and connection is ${connection == null}');
    notifyListeners();
  }
}
