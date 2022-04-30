// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_watch/services/service.dart';
import 'package:smart_watch/ui/pages/forgetpass.dart';
import 'package:smart_watch/ui/pages/home.dart';
import 'package:smart_watch/ui/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({Key? key}) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  //form key
  final auth = Auth();
  var user_id;
  final _formKey = GlobalKey<FormState>();
  final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  String _error = '';
  bool isValidForm = false;
  bool isLoading = false;

  //editing controller
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  validateSignIn() async {
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
        user_id =
            await auth.signIn(emailcontroller.text, passwordcontroller.text);
        setState(() {
          isLoading = false;
        });
      } on FirebaseAuthException catch (e) {
        print(e);
        setState(() {
          isLoading = false;
          if (e.code == 'user-not-found') {
            _error = 'The email entered is unregistered';
          } else if (e.code == 'network-request-failed') {
            _error = 'Please connect to internet and try again';
          } else
            _error = e.message.toString();
        });
      }
      if (user_id != null) {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const Homepg(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //emailfield
    final emailField = TextFormField(
      autofocus: false,
      controller: emailcontroller,
      keyboardType: TextInputType.emailAddress,
      //validator: () {},
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
      validator: (inputValue) {
        if (inputValue!.isEmpty) {
          return "Email field can't be empty!";
        }
        if (!_emailRegex.hasMatch(inputValue)) {
          return "Please enter proper email";
        }

        return null;
      },
    );
    //paswd
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordcontroller,
      obscureText: true,
      onSaved: (value) {
        passwordcontroller.text = value!;
      },
      textInputAction: TextInputAction.done,
      validator: (inputValue) {
        if (inputValue!.isEmpty) {
          return "Password field can't be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
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
        textStyle: const TextStyle(fontSize: 15),
        primary: const Color(0xffFFC76C),
        onPrimary: Colors.black,
        minimumSize: const Size(312, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
      ),
      onPressed: () async => validateSignIn(),
      child: const Text(
        'Login now',
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
                              'Login to your account',
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
                          child: passwordField,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            _error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      print('Forgot Password!');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const ForgetPassword()));
                                    },
                                    child: const Text(
                                      'Forget Password?',
                                      textAlign: TextAlign.end,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        loginbutton,
                        Padding(
                            padding: const EdgeInsets.all(15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const Signupscreen()));
                              },
                              child: const Text(
                                'Don\'t have a account?',
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
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }
}
