import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_watch/ui/pages/maps.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({Key? key, required this.userDocument}) : super(key: key);
  final userDocument;
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
                          color: Color(0xFFCCF0C0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(24),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 65,
                        left: 85,
                        child: Text(
                          "Live Location",
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
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
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.52,
                          width: MediaQuery.of(context).size.width * 0.56,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF4F4F9),
                            borderRadius: BorderRadius.all(
                              Radius.circular(24),
                            ),
                          ),
                          child: const Maps(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
