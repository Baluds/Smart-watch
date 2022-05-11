import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smart_watch/model/model.dart';

class Devicepg extends StatefulWidget {
  const Devicepg({Key? key, required this.userDocument}) : super(key: key);
  final userDocument;

  @override
  State<Devicepg> createState() => _DevicepgState();
}

class _DevicepgState extends State<Devicepg> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  final FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection? connection;
  late Uint8List uint8List;
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice? _device;
  bool _connected = false;
  bool _isButtonUnavailable = false;
  String _messageBuffer = '';
  List<String> messages = [];
  String messageData = '';
  bool isDisconnecting = false;

  bool get isConnected => ((connection?.isConnected) ?? false);
  late Model tesT;

  @override
  void initState() {
    super.initState();
    tesT = Provider.of<Model>(context, listen: false);
    Model blueProvider = Provider.of<Model>(context, listen: false);
    connection = blueProvider.connection;
    _device = blueProvider.device;
    _connected = connection != null && _device != null ? true : false;
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
      if (state == BluetoothState.STATE_ON) {
        blueProvider.changebluetoothEnabled(true);
      }
    });
    enableBluetooth();
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      _bluetoothState = state;
      if (_bluetoothState == BluetoothState.STATE_OFF) {
        if (mounted) {
          setState(() {
            _isButtonUnavailable = true;
            _connected = false;
            connection = null;
          });
        }
        blueProvider.changebluetoothEnabled(false);
        blueProvider.setBlueDetails(null, null);
      }
      if (state == BluetoothState.STATE_ON) {
        blueProvider.changebluetoothEnabled(true);
      }
      getPairedDevices();
    });
  }

  Future enableBluetooth() async {
    _bluetoothState = await FlutterBluetoothSerial.instance.state;
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();
      return true;
    } else {
      await getPairedDevices();
    }
    return false;
  }

  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];
    try {
      devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _devicesList = devices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/home_bg.png"),
              fit: BoxFit.cover,
            )),
          ),
          Positioned(
            right: 0,
            top: MediaQuery.of(context).size.height * 0.06,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: const BoxDecoration(
                color: Color(0xFFF4F4F9),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 140, top: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey)),
                        ),
                        Text(
                          widget.userDocument['Name'],
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w700)),
                        )
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05,
                        ),
                        height: MediaQuery.of(context).size.height * 0.655,
                        width: MediaQuery.of(context).size.width * 0.71,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFDCA2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(24),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.70,
                        child: Visibility(
                          visible: _isButtonUnavailable &&
                              _bluetoothState == BluetoothState.STATE_ON,
                          child: const LinearProgressIndicator(
                            backgroundColor: Color(0xFF191847),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFFFDCA2)),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 95,
                        left: 50,
                        child: Text(
                          "Bluetooth Connection",
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 10,
                        child: Material(
                          color: Colors.transparent,
                          shape: const CircleBorder(),
                          clipBehavior: Clip.hardEdge,
                          child: IconButton(
                            icon: const FaIcon(FontAwesomeIcons.circleXmark),
                            onPressed: () {
                              //print('hiiiiiiiiii');
                              //print(_device?.name);
                              Navigator.pop(context, {
                                "connection": connection,
                                "blueDevice": _device,
                              });
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 130,
                        left: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 35),
                              child: Text(
                                'Enable Bluetooth',
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Switch(
                              value: _bluetoothState.isEnabled,
                              onChanged: (bool value) {
                                future() async {
                                  if (value) {
                                    await FlutterBluetoothSerial.instance
                                        .requestEnable();
                                  } else {
                                    await FlutterBluetoothSerial.instance
                                        .requestDisable();
                                  }

                                  await getPairedDevices();
                                  _isButtonUnavailable = false;

                                  if (_connected) {
                                    _disconnect();
                                  }
                                }

                                future().then((_) {
                                  setState(() {});
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 180,
                        left: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: Text(
                                'Devices:',
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.38,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  isExpanded: true,
                                  hint: Text(
                                    'Select Watch',
                                    style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                  iconSize: 30,
                                  buttonHeight:
                                      MediaQuery.of(context).size.height * 0.04,
                                  buttonWidth:
                                      MediaQuery.of(context).size.width * 0.4,
                                  buttonPadding: const EdgeInsets.only(
                                      left: 20, right: 10),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  items: _getDeviceItems(),
                                  customItemsIndexes: _getDividersIndexes(),
                                  itemHeight: 25,
                                  customItemsHeight: 6,
                                  itemPadding: const EdgeInsets.only(
                                    left: 5,
                                    right: 5,
                                  ),
                                  onChanged: (value) => setState(
                                      () => _device = value as BluetoothDevice),
                                  value:
                                      _devicesList.isNotEmpty ? _device : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 230,
                        left: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                right: 24,
                              ),
                              padding: const EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width * 0.26,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(0),
                                  textStyle: const TextStyle(fontSize: 15),
                                  primary: const Color(0xffFFC76C),
                                  onPrimary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12), // <-- Radius
                                  ),
                                ),
                                child: Text(
                                  _connected ? 'Disconnect' : 'Connect',
                                  style: GoogleFonts.nunito(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                onPressed: _isButtonUnavailable
                                    ? null
                                    : _connected
                                        ? _disconnect
                                        : _connect,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.26,
                              child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Colors.black,
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                  textStyle: const TextStyle(fontSize: 15),
                                  primary: const Color(0xffFFC76C),
                                  onPrimary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12), // <-- Radius
                                  ),
                                ),
                                label: Text(
                                  'Refresh',
                                  style: GoogleFonts.nunito(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  await getPairedDevices().then((_) {
                                    show('Device list refreshed');
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 260,
            right: ((connection?.isConnected) ?? false) ? 100 : 73,
            child: Text(
              ((connection?.isConnected) ?? false)
                  ? 'You’re connected to\n${_device?.name}'
                  : 'You’re not connected to any\ndevices',
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            right: 45,
            bottom: 165,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                'Note: If you cannot find the device in the list, please pair the device by going to the Bluetooth Settings',
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 127,
            bottom: 100,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  primary: const Color(0xffFFC76C),
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
                child: Text(
                  'Bluetooth Settings',
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                onPressed: () {
                  FlutterBluetoothSerial.instance.openSettings();
                },
              ),
            ),
          )
        ],
      )),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text(
          'NONE',
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ));
    } else {
      for (var device in _devicesList) {
        items.addAll(
          [
            DropdownMenuItem(
              child: Text(
                device.name ?? '',
                maxLines: 1,
              ),
              value: device,
            ),
            if (device != _devicesList.last)
              const DropdownMenuItem(
                enabled: false,
                child: Divider(),
              ),
          ],
        );
      }
    }
    return items;
  }

  List<int> _getDividersIndexes() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (_devicesList.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }

  // Method to connect to bluetooth
  void _connect() async {
    Model blueProvider = Provider.of<Model>(context, listen: false);
    setState(() {
      _isButtonUnavailable = true;
    });
    if (_device == null) {
      show('No device selected');
    } else {
      if (!isConnected) {
        await BluetoothConnection.toAddress(_device?.address)
            .then((_connection) {
          print('Connected to the device');
          connection = _connection;
          blueProvider.setBlueDetails(_device, connection);
          setState(() {
            _connected = true;
          });

          connection?.input?.listen(_onDataReceived).onDone(() {
            print(_messageBuffer);
            print('disconnected');
            blueProvider.setBlueDetails(null, null);
            setState(() {
              messageData = _messageBuffer;
            });
            if (isDisconnecting) {
              print('Disconnecting locally!');
            } else {
              print('Disconnected remotely!');
            }
            if (mounted) {
              setState(() {});
            }
          });
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          print(error);
        });
        show('Device connected');

        setState(() => _isButtonUnavailable = false);
      }
    }
  }

  void _onDataReceived(Uint8List data) {
    if (String.fromCharCodes(data) == '\n') {
      print(_messageBuffer);
      if (_messageBuffer.substring(0, 4) == 'Spo2') {
        tesT.setSpo2Value(int.parse(_messageBuffer.substring(5)));
      }
      if (_messageBuffer.substring(0, 2) == 'HR') {
        tesT.setHrValue(int.parse(_messageBuffer.substring(3)));
      }
      if (mounted) {
        setState(() {
          messageData = _messageBuffer;
        });
      }
      _messageBuffer = '';
    } else {
      _messageBuffer = _messageBuffer + String.fromCharCodes(data);
    }
  }

  // Method to disconnect bluetooth
  void _disconnect() async {
    Model blueProvider = Provider.of<Model>(context, listen: false);
    setState(() {
      _isButtonUnavailable = true;
    });

    await connection?.close();
    show('Device disconnected');
    if (!((connection?.isConnected) ?? false)) {
      blueProvider.setBlueDetails(null, null);
      setState(() {
        _connected = false;
        _isButtonUnavailable = false;
        connection = null;
      });
    }
  }

  void show(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
