import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_watch/model/model.dart';
import 'package:smart_watch/services/service.dart';

class Spo2pg extends StatefulWidget {
  const Spo2pg({Key? key, required this.userDocument}) : super(key: key);
  final userDocument;

  @override
  State<Spo2pg> createState() => _Spo2pgState();
}

class _Spo2pgState extends State<Spo2pg> {
  var document;
  @override
  void initState() {
    super.initState();
    Auth().getData(widget.userDocument['Uid']).then((value) {
      setState(() {
        document = value;
      });
    });
  }

  bool sleepPositionDetection(int spo2) {
    var pregnancySpo2 = document == null
        ? widget.userDocument['Pregnancy']
        : document['Pregnancy'];
    if (pregnancySpo2 == 3) {
      if (spo2 >= 95 && spo2 <= 100) {
        return true;
      }
      return false;
    } else if (pregnancySpo2 == 2) {
      if (spo2 >= 93.4 && spo2 <= 98.5) {
        return true;
      }
      return false;
    } else if (pregnancySpo2 == 1) {
      if (spo2 >= 92.9 && spo2 <= 99.3) {
        return true;
      }
      return false;
    } else {
      if (spo2 >= 94.3 && spo2 <= 99.4) {
        return true;
      }
      return false;
    }
  }

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
                      margin: const EdgeInsets.only(right: 140, top: 25),
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
                          height: MediaQuery.of(context).size.height * 0.64,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: const BoxDecoration(
                            color: Color(0xFFBAE5F5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(24),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 55,
                          left: 15,
                          child: Material(
                            color: Colors.transparent,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.hardEdge,
                            child: IconButton(
                              icon: const FaIcon(FontAwesomeIcons.circleXmark),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          top: 100,
                          left: 28,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Text(
                                  "Blood Oxygen Monitor",
                                  style: GoogleFonts.nunito(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.56,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF89C5CC),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(24),
                                        ),
                                        border: Border.all(
                                          color: const Color(0xFF388A9A),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 25,
                                      left: 12,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.14,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.14,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/o2.png"),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 70,
                                      top: 25,
                                      child: Consumer<Model>(
                                        builder:
                                            (context, blueProvider, child) =>
                                                Text(
                                          '${blueProvider.sp02}',
                                          style: GoogleFonts.nunito(
                                            textStyle: const TextStyle(
                                              fontSize: 64,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 135,
                                      top: 18,
                                      child: Text(
                                        "%SpO2",
                                        style: GoogleFonts.nunito(
                                          textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 15, bottom: 10),
                                child: Consumer<Model>(
                                  builder: (context, blueProvider, child) =>
                                      Text(
                                    blueProvider.sp02! >= 90 &&
                                            blueProvider.sp02! <= 100
                                        ? "Your Oxygen Level is normal!\n"
                                        : "Your Oxygen Level is Abnormal!\nSeek Medical Help.",
                                    style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.56,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF89C5CC),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(24),
                                        ),
                                        border: Border.all(
                                          color: const Color(0xFF388A9A),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 35,
                                      left: 20,
                                      child: Consumer<Model>(
                                        builder:
                                            (context, blueProvider, child) =>
                                                Text(
                                          sleepPositionDetection(
                                                  blueProvider.sp02 ?? 97)
                                              ? "Your are sleeping in the\nright posiiton."
                                              : "Your are not sleeping in the\nright posiiton.",
                                          style: GoogleFonts.nunito(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
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
}
