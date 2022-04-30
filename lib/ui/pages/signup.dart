import 'dart:ffi';
import 'dart:ui';

// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_watch/services/service.dart';
import 'package:smart_watch/ui/pages/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({Key? key}) : super(key: key);

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  //form key
  final _formKey = GlobalKey<FormState>();
  final auth = Auth();
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    //await Firebase.initializeApp();
  }

  final RegExp _passRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
  final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  //final _auth = FirebaseAuth.instance;
  String _error = '';
  String user_id = '';
  bool isValidForm = false;
  bool isLoading = false;
  //editing controller
  final TextEditingController namecontroller = new TextEditingController();
  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passwordcontroller = new TextEditingController();

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
      print('invalid');
    } else {
      try {
        setState(() {
          isLoading = true;
          _error = '';
        });
        user_id = await auth.signUp(
            emailcontroller.text, passwordcontroller.text, namecontroller.text);
        setState(() {
          isLoading = false;
        });
      } on FirebaseAuthException catch (e) {
        print(e);
        print(e.code);
        setState(() {
          isLoading = false;
          if (e.code == 'network-request-failed') {
            _error = 'Please connect to internet and try again';
          } else
            _error = e.message.toString();
        });
      }
      if (user_id == '') {
      } else {
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
                "Your account has been created",
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const Loginscreen()));
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
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (BuildContext context) => const Loginscreen(),
        //   ),
        // );
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
      //validator: () {},
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
        fillColor: Colors.white,
        hintText: "Email Address",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
    //paswd
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordcontroller,
      obscureText: true,
      validator: (inputValue) {
        if (inputValue!.isEmpty || !_passRegex.hasMatch(inputValue)) {
          return "Please enter Minimum eight characters, at least one letter, one number and one special character";
        }
        return null;
      },
      onSaved: (value) {
        passwordcontroller.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        filled: true,
        fillColor: Colors.white,
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
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
        'Create an account',
      ),
    );
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F9),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator(
                color: Color(0xffFFC76C),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              child: Image.asset('assets/images/logo.png'),
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            )),
                        const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Create an account',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: name,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: emailField,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: passwordField,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: loginbutton,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            '$_error',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const Loginscreen()));
                              },
                              child: const Text(
                                'Already have an account?',
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }
}
