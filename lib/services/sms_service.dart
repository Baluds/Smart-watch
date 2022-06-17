import 'dart:convert';

import 'package:background_location/background_location.dart';
import 'package:smart_watch/constants/secret_keys.dart';
import 'package:smart_watch/services/service.dart';
import 'package:telephony/telephony.dart';
import 'package:http/http.dart' as http;

class SmsService {
  void sendPanicsms(String uid, document) async {
    final Telephony telephony = Telephony.instance;
    var userDocument = await Auth().getData(uid);
    Location _currentPosition;
    _currentPosition = await BackgroundLocation().getCurrentLocation();
    telephony.sendSms(
      to: userDocument == null
          ? document["EmergencyContact1"]
          : userDocument["EmergencyContact1"],
      message:
          "Help me , my location is https://www.google.com/maps/search/?api=1&query=${_currentPosition.latitude}%2C${_currentPosition.longitude}",
    );
    telephony.sendSms(
      to: userDocument == null
          ? document["EmergencyContact2"]
          : userDocument["EmergencyContact2"],
      message:
          "Help me , my location is https://www.google.com/maps/search/?api=1&query=${_currentPosition.latitude}%2C${_currentPosition.longitude}",
    );
  }

  void sendFallsms(String uid, document) async {
    final Telephony telephony = Telephony.instance;
    var userDocument = await Auth().getData(uid);
    Location _currentPosition;
    _currentPosition = await BackgroundLocation().getCurrentLocation();
    telephony.sendSms(
      to: userDocument == null
          ? document["EmergencyContact1"]
          : userDocument["EmergencyContact1"],
      message:
          "I fell in location https://www.google.com/maps/search/?api=1&query=${_currentPosition.latitude}%2C${_currentPosition.longitude} , please contact and provide medical assistance immediately",
    );
    telephony.sendSms(
      to: userDocument == null
          ? document["EmergencyContact2"]
          : userDocument["EmergencyContact2"],
      message:
          "I fell in location https://www.google.com/maps/search/?api=1&query=${_currentPosition.latitude}%2C${_currentPosition.longitude} , please contact and provide medical assistance immediately",
    );
  }

  void sendFallSosMail(String uid, document, bool fall) async {
    var userDocument = await Auth().getData(uid);
    String person =
        userDocument == null ? document["Name"] : userDocument["Name"];
    String to_emergency1 = userDocument == null
        ? document["EmergencyContact1mail"]
        : userDocument["EmergencyContact1mail"];
    String to_emergency2 = userDocument == null
        ? document["EmergencyContact2mail"]
        : userDocument["EmergencyContact2mail"];
    String to_emergency3 = userDocument == null
        ? document["EmergencyContact3mail"]
        : userDocument["EmergencyContact3mail"];
    String to_emergency4 = userDocument == null
        ? document["EmergencyContact4mail"]
        : userDocument["EmergencyContact4mail"];
    Location _currentPosition;
    _currentPosition = await BackgroundLocation().getCurrentLocation();
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': SecretKeys().serviceId,
        'template_id':
            fall ? SecretKeys().fallTemplate : SecretKeys().sosTemplate,
        'user_id': SecretKeys().userId,
        'accessToken': SecretKeys().accessToken,
        'template_params': {
          'person': person,
          'my_location':
              'https://www.google.com/maps/search/?api=1&query=${_currentPosition.latitude}%2C${_currentPosition.longitude}',
          'to_address': 'smartwatchproject22@gmail.com',
          'reply_to': 'smartwatchproject22@gmail.com',
          'to_emergency1': to_emergency1,
          'to_emergency2': to_emergency2,
          'to_emergency3': to_emergency3,
          'to_emergency4': to_emergency4,
        }
      }),
    );
    print(response.body);
  }
}
