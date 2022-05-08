import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_watch/services/service.dart';
import 'package:smart_watch/test.dart';
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

  var result = {};
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
                              child: Material(
                                color: Colors.transparent,
                                child: InkResponse(
                                  highlightColor: const Color(0xffFFC76C),
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Devicepg(
                                          userDocument: userDocument,
                                          conn: result["connection"],
                                          blueDevice: result["blueDevice"],
                                        ),
                                      ),
                                    ).then((value) {
                                      setState(() {
                                        result = value;
                                        print(result["connection"] == null);
                                      });
                                    });
                                  },
                                  child: Text(
                                    (result["connection"] != null)
                                        ? "${result["blueDevice"].name} is connected!"
                                        : "Your device is not connected!",
                                    style: GoogleFonts.nunito(
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Menu(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.2,
                          imageName: "assets/images/Profile.png",
                          multiple: 1,
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
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.15,
                          imageName: "assets/images/location.png",
                          multiple: 1,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Menu(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.15,
                              imageName: "assets/images/SPO2.png",
                              multiple: 2,
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
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.15,
                              imageName: "assets/images/SOS.png",
                              multiple: 3,
                              callback: () {},
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Menu(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                imageName: "assets/images/heart_rate.png",
                                multiple: 2,
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
                            Stack(
                              children: [
                                Menu(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  imageName: "assets/images/fall.png",
                                  multiple: 3,
                                  callback: () =>
                                      fallDialog(context, userDocument),
                                ),
                                Positioned(
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.04,
                                  left:
                                      MediaQuery.of(context).size.width * 0.06,
                                  child: InkResponse(
                                    onTap: () =>
                                        fallDialog(context, userDocument),
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
