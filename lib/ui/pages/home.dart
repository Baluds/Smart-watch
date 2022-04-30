import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_watch/ui/pages/heartrate.dart';
import 'package:smart_watch/ui/pages/mapsoutline.dart';
import 'package:smart_watch/ui/pages/profile.dart';
import 'package:smart_watch/ui/pages/spo2.dart';

import '../../widgets/menu.dart';

class Homepg extends StatelessWidget {
  const Homepg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            "Balachandra",
                            style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w700)),
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
                          child: Text(
                            "Your device is connected!",
                            style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                          ),
                        )
                      ],
                    ),
                    Menu(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.2,
                      imageName: "assets/images/Profile.png",
                      multiple: 1,
                      callback: () {
                        print("clicked profile");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const EditProfile()));
                      },
                    ),
                    Menu(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.15,
                      imageName: "assets/images/location.png",
                      multiple: 1,
                      callback: () {
                        print("clicked location");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const MapsPage()));
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Menu(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.15,
                          imageName: "assets/images/SPO2.png",
                          multiple: 2,
                          callback: () {
                            print("Clicked spo2");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const spo2pg()));
                          },
                        ),
                        Menu(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.15,
                          imageName: "assets/images/SOS.png",
                          multiple: 3,
                          callback: () {
                            print("clicked s0s");
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Menu(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.15,
                            imageName: "assets/images/heart_rate.png",
                            multiple: 2,
                            callback: () {
                              print("clicked heartrate");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const Heartratepg()));
                            }),
                        Stack(
                          children: [
                            Menu(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.15,
                              imageName: "assets/images/fall.png",
                              multiple: 3,
                              callback: () => fallDialog(context),
                            ),
                            Positioned(
                              bottom: MediaQuery.of(context).size.height * 0.04,
                              left: MediaQuery.of(context).size.width * 0.06,
                              child: InkResponse(
                                onTap: () => fallDialog(context),
                                child: Text(
                                  '  Fall\nDetected',
                                  style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      )),
    );
  }

  Future<String?> fallDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: const Color(0xFFC1DEE2),
        insetPadding: const EdgeInsets.only(bottom: 520),
        actionsAlignment: MainAxisAlignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(
            color: Color(0xFFFFDCA2),
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
                  builder: (BuildContext context) => const MapsPage(),
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
