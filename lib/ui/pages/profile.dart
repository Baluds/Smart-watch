// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_watch/services/service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.userDocument}) : super(key: key);
  final userDocument;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool isValidForm = false;
  String _error = '';
  final auth = Auth();
  bool isLoading = false;
  bool pregnantBool = false;
  int pregnancy = 3;
  late TextEditingController namecontroller;
  late TextEditingController emailcontroller;
  late TextEditingController phonecontroller;
  late TextEditingController emergencycontroller1;
  late TextEditingController emergencycontroller2;
  late TextEditingController emergencycontroller3;
  late TextEditingController emergencycontroller4;
  late final TextEditingController emerg1mailcontroller;
  late final TextEditingController emerg2mailcontroller;
  late final TextEditingController emerg3mailcontroller;
  late final TextEditingController emerg4mailcontroller;
  late final TabController _tabController;

  final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  final RegExp _phoneRegex = RegExp(r'^[0-9]{10}$');
  //editing controller
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    namecontroller = TextEditingController(text: widget.userDocument['Name']);
    emailcontroller = TextEditingController(text: widget.userDocument['Email']);
    phonecontroller = TextEditingController(text: widget.userDocument['Phone']);
    emergencycontroller1 =
        TextEditingController(text: widget.userDocument['EmergencyContact1']);
    emergencycontroller2 =
        TextEditingController(text: widget.userDocument['EmergencyContact2']);
    emergencycontroller3 =
        TextEditingController(text: widget.userDocument['EmergencyContact3']);
    emergencycontroller4 =
        TextEditingController(text: widget.userDocument['EmergencyContact4']);
    emerg1mailcontroller = TextEditingController(
        text: widget.userDocument['EmergencyContact1mail']);
    emerg2mailcontroller = TextEditingController(
        text: widget.userDocument['EmergencyContact2mail']);
    emerg3mailcontroller = TextEditingController(
        text: widget.userDocument['EmergencyContact3mail']);
    emerg4mailcontroller = TextEditingController(
        text: widget.userDocument['EmergencyContact4mail']);
    pregnantBool = widget.userDocument['IsPregnant'];
    _tabController.index = widget.userDocument['Pregnancy'] == 3
        ? 1
        : widget.userDocument['Pregnancy'];
  }

  validateSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isValidForm = true;
      });
    } else {
      setState(() {
        isValidForm = false;
      });
    }
    if (!isValidForm) {
    } else {
      try {
        setState(() {
          isLoading = true;
          _error = '';
        });
        await auth.updateUser({
          'Name': namecontroller.text,
          'Uid': widget.userDocument['Uid'],
          'Phone': phonecontroller.text,
          'EmergencyContact1': emergencycontroller1.text,
          'EmergencyContact2': emergencycontroller2.text,
          'EmergencyContact3': emergencycontroller3.text,
          'EmergencyContact4': emergencycontroller4.text,
          'EmergencyContact1mail': emerg1mailcontroller.text,
          'EmergencyContact2mail': emerg2mailcontroller.text,
          'EmergencyContact3mail': emerg3mailcontroller.text,
          'EmergencyContact4mail': emerg4mailcontroller.text,
          'IsPregnant': pregnantBool,
          'Pregnancy': pregnantBool == false ? 3 : pregnancy,
        });
        setState(() {
          isLoading = false;
        });
      } on FirebaseException catch (e) {
        print(e);
        print(e.code);
        setState(() {
          isLoading = false;
          if (e.code == 'network-request-failed') {
            _error = 'Please connect to internet and try again';
          } else {
            _error = e.message.toString();
          }
        });
      }
      if (_error == '') {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: const Color(0xFFFFDCA2),
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
                "Account details has been updated successfully!",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700)),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Ok',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 100, 95, 51),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //name
    final name = TextFormField(
      autofocus: false,
      controller: namecontroller,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        namecontroller.text = value!;
      },
      validator: (inputValue) {
        if (inputValue!.isEmpty) {
          return "Name field can't be empty";
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        filled: true,
        fillColor: Colors.white,
        hintText: "Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );

    //emailfield
    final emailField = TextFormField(
        autofocus: false,
        readOnly: true,
        controller: emailcontroller,
        keyboardType: TextInputType.emailAddress,
        validator: (inputValue) {
          if (inputValue!.isEmpty) {
            return "Email field can't be empty!";
          }
          if (!_emailRegex.hasMatch(inputValue)) {
            return "Please enter proper email";
          }

          return null;
        },
        onSaved: (value) {
          emailcontroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          filled: true,
          fillColor: const Color.fromARGB(255, 229, 229, 229),
          hintText: "Email Address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ));
    final phoneField = TextFormField(
        autofocus: false,
        controller: phonecontroller,
        keyboardType: TextInputType.phone,
        validator: (inputValue) {
          if (inputValue!.isEmpty) {
            return "Phone field can't be empty!";
          }
          if (!_phoneRegex.hasMatch(inputValue)) {
            return "Please enter proper number";
          }

          return null;
        },
        onSaved: (value) {
          phonecontroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          filled: true,
          fillColor: Colors.white,
          hintText: "Phone Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ));
    final emergencyfield1 = TextFormField(
        autofocus: false,
        controller: emergencycontroller1,
        keyboardType: TextInputType.phone,
        validator: (inputValue) {
          if (inputValue!.isEmpty) {
            return "Phone field can't be empty!";
          }
          if (!_phoneRegex.hasMatch(inputValue)) {
            return "Please enter proper number";
          }

          return null;
        },
        onSaved: (value) {
          emergencycontroller1.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          filled: true,
          fillColor: Colors.white,
          hintText: "Emergency Contact 1",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ));
    final emergencyfield2 = TextFormField(
        autofocus: false,
        controller: emergencycontroller2,
        keyboardType: TextInputType.phone,
        validator: (inputValue) {
          if (inputValue!.isEmpty) {
            return "Phone field can't be empty!";
          }
          if (!_phoneRegex.hasMatch(inputValue)) {
            return "Please enter proper number";
          }

          return null;
        },
        onSaved: (value) {
          emergencycontroller2.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          filled: true,
          fillColor: Colors.white,
          hintText: "Emergency Contact 2",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ));
    final emergencyfield3 = TextFormField(
        autofocus: false,
        controller: emergencycontroller3,
        keyboardType: TextInputType.phone,
        validator: (inputValue) {
          if (inputValue!.isEmpty) {
            return "Phone field can't be empty!";
          }
          if (!_phoneRegex.hasMatch(inputValue)) {
            return "Please enter proper number";
          }

          return null;
        },
        onSaved: (value) {
          emergencycontroller3.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          filled: true,
          fillColor: Colors.white,
          hintText: "Emergency Contact 3",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ));
    final emergencyfield4 = TextFormField(
        autofocus: false,
        controller: emergencycontroller4,
        keyboardType: TextInputType.phone,
        validator: (inputValue) {
          if (inputValue!.isEmpty) {
            return "Phone field can't be empty!";
          }
          if (!_phoneRegex.hasMatch(inputValue)) {
            return "Please enter proper number";
          }

          return null;
        },
        onSaved: (value) {
          emergencycontroller4.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          filled: true,
          fillColor: Colors.white,
          hintText: "Emergency Contact 4",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ));

    final emerg1mailField = TextFormField(
        autofocus: false,
        controller: emerg1mailcontroller,
        keyboardType: TextInputType.emailAddress,
        validator: (inputValue) {
          if (inputValue!.isEmpty) {
            return "Email field can't be empty!";
          }
          if (!_emailRegex.hasMatch(inputValue)) {
            return "Please enter proper email";
          }

          return null;
        },
        onSaved: (value) {
          emerg1mailcontroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          filled: true,
          fillColor: Colors.white,
          hintText: "Emergency contact 1 Email Address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ));

    final emerg2mailField = TextFormField(
        autofocus: false,
        controller: emerg2mailcontroller,
        keyboardType: TextInputType.emailAddress,
        validator: (inputValue) {
          if (inputValue!.isEmpty) {
            return "Email field can't be empty!";
          }
          if (!_emailRegex.hasMatch(inputValue)) {
            return "Please enter proper email";
          }

          return null;
        },
        onSaved: (value) {
          emerg2mailcontroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          filled: true,
          fillColor: Colors.white,
          hintText: "Emergency contact 2 Email Address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ));

    final emerg3mailField = TextFormField(
        autofocus: false,
        controller: emerg3mailcontroller,
        keyboardType: TextInputType.emailAddress,
        validator: (inputValue) {
          if (inputValue!.isEmpty) {
            return "Email field can't be empty!";
          }
          if (!_emailRegex.hasMatch(inputValue)) {
            return "Please enter proper email";
          }

          return null;
        },
        onSaved: (value) {
          emerg3mailcontroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          filled: true,
          fillColor: Colors.white,
          hintText: "Emergency contact 3 Email Address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ));

    final emerg4mailField = TextFormField(
        autofocus: false,
        controller: emerg4mailcontroller,
        keyboardType: TextInputType.emailAddress,
        validator: (inputValue) {
          if (inputValue!.isEmpty) {
            return "Email field can't be empty!";
          }
          if (!_emailRegex.hasMatch(inputValue)) {
            return "Please enter proper email";
          }

          return null;
        },
        onSaved: (value) {
          emerg4mailcontroller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          filled: true,
          fillColor: Colors.white,
          hintText: "Emergency contact 1 Email Address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ));

    final loginbutton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 15,
        ),
        primary: const Color(0xffFFC76C),
        onPrimary: Colors.black,
        minimumSize: const Size(312, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
      ),
      onPressed: () async => validateSignUp(),
      child: const Text(
        'Submit',
      ),
    );
    final pregnant = Row(
      children: [
        Text(
          'Are you pregnant?',
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Switch(
          value: pregnantBool,
          onChanged: (bool value) {
            setState(() {
              pregnantBool = !pregnantBool;
              pregnantBool == false ? pregnancy = 3 : pregnancy = pregnancy;
            });
          },
        ),
      ],
    );
    final pregTab = TabBar(
      controller: _tabController,
      onTap: (index) {
        print(index);
        setState(() {
          pregnancy = index;
        });
      },
      unselectedLabelColor: const Color(0xFF191847),
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color.fromARGB(255, 255, 157, 0),
            Color(0xFFFFC76C),
            Color.fromARGB(255, 255, 209, 134),
          ]),
          borderRadius: BorderRadius.circular(50),
          color: const Color(0xFF191847)),
      tabs: const [
        Tab(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "First Trimester",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Second Trimester",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Tab(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Third Trimester",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/profile_bg.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Color(0xffFFC76C),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                              child: Column(
                                children: [
                                  const Text(
                                    'A little more about you,',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    widget.userDocument['Name'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.all(15),
                              child:
                                  Image.asset('assets/images/profile_pic.png')),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: name,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: emailField,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: phoneField,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: emergencyfield1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: emerg1mailField,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: emergencyfield2,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: emerg2mailField,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: emergencyfield3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: emerg3mailField,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: emergencyfield4,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: emerg4mailField,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: pregnant,
                          ),
                          pregnantBool
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    left: 5,
                                    right: 5,
                                    bottom: 15,
                                  ),
                                  child: pregTab,
                                )
                              : Container(),
                          loginbutton,
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    phonecontroller.dispose();
    emergencycontroller1.dispose();
    emergencycontroller2.dispose();
  }
}
