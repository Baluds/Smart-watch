import 'package:background_location/background_location.dart';
import 'package:smart_watch/services/service.dart';
import 'package:telephony/telephony.dart';

class SmsService {
  final Telephony telephony = Telephony.instance;
  void sendPanicsms(String uid) async {
    var userDocument = await Auth().getData(uid);
    Location _currentPosition;
    _currentPosition = await BackgroundLocation().getCurrentLocation();
    telephony.sendSms(
      to: userDocument["EmergencyContact1"],
      message:
          "Help me , my location is https://www.google.com/maps/search/?api=1&query=${_currentPosition.latitude}%2C${_currentPosition.longitude}",
    );
    telephony.sendSms(
      to: userDocument["EmergencyContact2"],
      message:
          "Help me , my location is https://www.google.com/maps/search/?api=1&query=${_currentPosition.latitude}%2C${_currentPosition.longitude}",
    );
  }
}
