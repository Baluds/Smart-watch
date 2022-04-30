// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_watch/ui/pages/forgetpass.dart';
import 'package:smart_watch/ui/pages/home.dart';
import 'package:smart_watch/ui/pages/signup.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({Key? key}) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  //form key
  final _formKey = GlobalKey<FormState>();
  final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  final String _error = '';
  bool isValidForm = false;

  //editing controller
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

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
        if (inputValue!.isEmpty || !_emailRegex.hasMatch(inputValue)) {
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
        !isValidForm
            ? print('invalid')
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const Homepg()));
        // try {
        //   await FirebaseAuth.instance.signInWithEmailAndPassword(
        //       email: emailcontroller.text, password: passwordcontroller.text);
        // } on FirebaseAuthException catch (e) {
        //   print('Failed with error code: ${e.code}');
        //   setState(() {
        //     _error = e.message.toString();
        //   });
        // }
      },
      child: const Text(
        'Login now',
      ),
    );
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F9),
      body: Center(
        child: SingleChildScrollView(
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
                          print('Don\'t have a account?');
                          Navigator.push(
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
}
