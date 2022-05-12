import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart' as loc;
import 'package:smart_watch/services/service.dart';
import 'package:smart_watch/ui/pages/home.dart';
import 'package:smart_watch/ui/pages/login.dart';
import 'package:smart_watch/ui/pages/signup.dart';
import 'package:smart_watch/widgets/painter.dart';
import 'package:telephony/telephony.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    enablePermission();
  }

  final Telephony telephony = Telephony.instance;
  void enablePermission() async {
    await telephony.requestSmsPermissions;
    await FlutterBluetoothSerial.instance.requestEnable();
    await FlutterBackground.initialize(androidConfig: androidConfig);
    await FlutterBackground.enableBackgroundExecution();
    await BackgroundLocation.startLocationService();

    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }
  }

  loc.Location location = loc.Location();
  final auth = Auth();
  final androidConfig = const FlutterBackgroundAndroidConfig(
    notificationTitle: "Smart Watch app",
    notificationText:
        "Background notification for keeping the Smart Watch app running in the background",
    notificationImportance: AndroidNotificationImportance.Default,
    notificationIcon: AndroidResource(
      name: 'background_icon',
      defType: 'drawable',
    ), // Default is ic_launcher from folder mipmap
  );
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: auth.firebaseAuth.authStateChanges(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Color(0xFF191847),
              body: SafeArea(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xffFFC76C),
                  ),
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Scaffold(
              backgroundColor: const Color(0xFF191847),
              body: SafeArea(
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.topCenter,
                            scale: 0.7,
                            image: AssetImage("assets/images/welcome.png"),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Color(0xFFF4F4F9),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(52),
                              topRight: Radius.circular(52),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CustomPaint(
                        painter: BgPainter(),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.60,
                      left: MediaQuery.of(context).size.width * 0.27,
                      child: Text(
                        "Hey, Welcome!",
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.70,
                      left: MediaQuery.of(context).size.width * 0.15,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const Signupscreen()));
                          },
                          child: Text(
                            "Get Started",
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffFFC76C)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.79,
                      left: MediaQuery.of(context).size.width * 0.15,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const Loginscreen()));
                          },
                          child: Text(
                            "I already have an account",
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffffffff)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              backgroundColor: const Color(0xFF191847),
              body: SafeArea(
                child: Center(child: Text('${snapshot.error}')),
              ),
            );
          }
          return Homepg(userId: snapshot.data.uid);
        });
  }
}
