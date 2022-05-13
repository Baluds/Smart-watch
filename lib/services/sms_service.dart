import 'package:background_location/background_location.dart';
import 'package:smart_watch/services/service.dart';
import 'package:telephony/telephony.dart';

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
}
