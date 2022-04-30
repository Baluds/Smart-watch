import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  String _error = '';
  bool isLoading = false;
  bool isValidForm = false;
  final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailcontroller = TextEditingController();
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
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        fillColor: Colors.white,
        hintText: "Email Address",
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
      onPressed: () async {
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
            await FirebaseAuth.instance
                .sendPasswordResetEmail(email: emailcontroller.text);
            setState(() {
              isLoading = false;
            });
          } on FirebaseAuthException catch (e) {
            setState(() {
              isLoading = false;
              if (e.code == 'user-not-found') {
                _error = 'The email entered is unregistered';
              } else if (e.code == 'network-request-failed') {
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
                    "Verification Email has been sent to email provided!",
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
                      'Go to login!',
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 100, 95, 51),
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
                        color: const Color.fromARGB(255, 100, 95, 51),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
      },
      child: const Text(
        'Submit',
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xffF4F4F9),
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
                              margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                            )),
                        const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Forgot your passsword?',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: emailField,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            _error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        loginbutton,
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
