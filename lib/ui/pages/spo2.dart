import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_watch/ui/pages/mapsoutline.dart';
import 'package:smart_watch/ui/pages/profile.dart';

import '../../widgets/menu.dart';

class spo2pg extends StatelessWidget {
  const spo2pg({Key? key, required this.userDocument}) : super(key: key);
  final userDocument;
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
                            userDocument['Name'],
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
                                print("close");
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
                                      child: Text(
                                        "75",
                                        style: GoogleFonts.nunito(
                                          textStyle: const TextStyle(
                                            fontSize: 64,
                                            fontWeight: FontWeight.w700,
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
                                child: Text(
                                  "Your Oxygen Level is Abnormal!\n           Seek Medical Help.",
                                  style: GoogleFonts.nunito(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
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
                                      child: Text(
                                        "Your are not sleeping in the\n           right posiiton.",
                                        style: GoogleFonts.nunito(
                                          textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
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
