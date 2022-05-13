import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:geocoding/geocoding.dart';

class Model extends ChangeNotifier {
  bool bluetoothEnabled = false;
  BluetoothDevice? device;
  BluetoothConnection? connection;
  int? sp02 = 97;
  int? hr = 90;
  Placemark? address;

  void changebluetoothEnabled(value) {
    bluetoothEnabled = value;
    notifyListeners();
  }

  void setBlueDetails(_device, conn) {
    device = _device;
    connection = conn;
    //print('device is ${device!.name} and connection is ${connection == null}');
    notifyListeners();
  }

  void setSpo2Value(value) {
    sp02 = value;
    notifyListeners();
  }

  void setHrValue(value) {
    hr = value;
    notifyListeners();
  }

  void setAddress(value) {
    address = value;
    notifyListeners();
  }
}
