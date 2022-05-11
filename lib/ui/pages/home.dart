import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_watch/model/model.dart';
import 'package:smart_watch/services/service.dart';
import 'package:smart_watch/ui/pages/devices.dart';
import 'package:smart_watch/ui/pages/heartrate.dart';
import 'package:smart_watch/ui/pages/mapsoutline.dart';
import 'package:smart_watch/ui/pages/profile.dart';
import 'package:smart_watch/ui/pages/spo2.dart';

import '../../widgets/menu.dart';

class Homepg extends StatefulWidget {
  const Homepg({Key? key, required this.userId}) : super(key: key);
  final String userId;
  @override
  State<Homepg> createState() => _HomepgState();
}

class _HomepgState extends State<Homepg> {
  final auth = Auth();
  _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth.users.doc(widget.userId).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            backgroundColor: Color(0xFF191847),
            body: SafeArea(
              child: Text('Something went wrong'),
            ),
          );
        }

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
        }
        var userDocument = snapshot.data;
        return Scaffold(
          backgroundColor: const Color(0xFF191847),
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
                                userDocument['Name'],
                                style: GoogleFonts.nunito(
                                    textStyle: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700)),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FaIcon(FontAwesomeIcons.circleExclamation),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Consumer<Model>(
                                builder: (context, blueProvider, child) => Text(
                                  (blueProvider.connection != null &&
                                          blueProvider.bluetoothEnabled == true)
                                      ? "${blueProvider.device!.name} is connected!"
                                      : "Your device is not connected!",
                                  style: GoogleFonts.nunito(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Menu(
                          width: MediaQuery.of(context).size.width * 0.62,
                          height: MediaQuery.of(context).size.height * 0.16,
                          menuColor: const Color(0xFFFFACAC),
                          multiple: 1,
                          childWidget: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/images/profile_pic.png',
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                              ),
                              Text(
                                'Profile',
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          callback: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => EditProfile(
                                  userDocument: userDocument,
                                ),
                              ),
                            );
                          },
                        ),
                        Menu(
                          width: MediaQuery.of(context).size.width * 0.62,
                          height: MediaQuery.of(context).size.height * 0.11,
                          menuColor: const Color(0xFFCCF0C0),
                          multiple: 1,
                          childWidget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: const FaIcon(
                                  FontAwesomeIcons.locationDot,
                                  size: 30,
                                ),
                              ),
                              Text(
                                'Location',
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          callback: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => MapsPage(
                                  userDocument: userDocument,
                                ),
                              ),
                            );
                          },
                        ),
                        Menu(
                          width: MediaQuery.of(context).size.width * 0.62,
                          height: MediaQuery.of(context).size.height * 0.11,
                          menuColor: const Color(0xFFFFDCA2),
                          multiple: 1,
                          childWidget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: const FaIcon(
                                  FontAwesomeIcons.bluetoothB,
                                  size: 30,
                                ),
                              ),
                              Text(
                                'Bluetooth',
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          callback: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Devicepg(
                                  userDocument: userDocument,
                                ),
                              ),
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Menu(
                              width: MediaQuery.of(context).size.width * 0.29,
                              height: MediaQuery.of(context).size.height * 0.11,
                              menuColor: const Color(0xFFBAE5F5),
                              multiple: 2,
                              childWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/spo21.png',
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                  ),
                                  Text(
                                    'Spo2',
                                    style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              callback: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Spo2pg(
                                              userDocument: userDocument,
                                            )));
                              },
                            ),
                            Menu(
                                width: MediaQuery.of(context).size.width * 0.29,
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                                menuColor: const Color(0xFFE2D3FE),
                                multiple: 3,
                                childWidget: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/heart.png',
                                      width: MediaQuery.of(context).size.width *
                                          0.12,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                    ),
                                    Text(
                                      'Heart\nRate',
                                      style: GoogleFonts.nunito(
                                        textStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                callback: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Heartratepg(
                                        userDocument: userDocument,
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 83,
                  right: 20,
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                    child: InkResponse(
                      onTap: () {
                        _signOut();
                      },
                      child: const FaIcon(FontAwesomeIcons.rightFromBracket),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String?> fallDialog(BuildContext context, dynamic userDocument) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: const Color(0xFFC1DEE2),
        insetPadding: const EdgeInsets.only(bottom: 520),
        actionsAlignment: MainAxisAlignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(
            color: Color(0xFFC1DEE2),
          ),
        ),
        titlePadding: const EdgeInsets.only(top: 15),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            "Fall detected!",
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MapsPage(
                    userDocument: userDocument,
                  ),
                ),
              );
            },
            child: Text(
              'Where?',
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.lightBlue,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text(
              'Call!',
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.lightBlue,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(
              'Cancel',
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.lightBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
