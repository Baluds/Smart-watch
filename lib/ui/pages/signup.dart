import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_watch/services/service.dart';
import 'package:smart_watch/ui/pages/login.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({Key? key}) : super(key: key);

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen>
    with SingleTickerProviderStateMixin {
  //form key
  final _formKey = GlobalKey<FormState>();
  final auth = Auth();
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    //await Firebase.initializeApp();
  }

  final RegExp _phoneRegex = RegExp(r'^[0-9]{10}$');
  final RegExp _passRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
  final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  //final _auth = FirebaseAuth.instance;
  String _error = '';
  String userId = '';
  bool isValidForm = false;
  bool isLoading = false;
  bool pregnantBool = false;
  int pregnancy = 3;
  //editing controller
  late final TabController _tabController;
  late final TextEditingController namecontroller;
  late final TextEditingController emailcontroller;
  late final TextEditingController passwordcontroller;
  late final TextEditingController phonecontroller;
  late final TextEditingController emerg1controller;
  late final TextEditingController emerg2controller;
  late final TextEditingController emerg3controller;
  late final TextEditingController emerg4controller;
  late final TextEditingController emerg1mailcontroller;
  late final TextEditingController emerg2mailcontroller;
  late final TextEditingController emerg3mailcontroller;
  late final TextEditingController emerg4mailcontroller;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    namecontroller = TextEditingController();
    emailcontroller = TextEditingController();
    passwordcontroller = TextEditingController();
    phonecontroller = TextEditingController();
    emerg1controller = TextEditingController();
    emerg2controller = TextEditingController();
    emerg3controller = TextEditingController();
    emerg4controller = TextEditingController();
    emerg1mailcontroller = TextEditingController();
    emerg2mailcontroller = TextEditingController();
    emerg3mailcontroller = TextEditingController();
    emerg4mailcontroller = TextEditingController();
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
        userId = await auth.signUp(
          emailcontroller.text,
          passwordcontroller.text,
          namecontroller.text,
          phonecontroller.text,
          emerg1controller.text,
          emerg2controller.text,
          emerg3controller.text,
          emerg4controller.text,
          emerg1mailcontroller.text,
          emerg2mailcontroller.text,
          emerg3mailcontroller.text,
          emerg4mailcontroller.text,
          pregnantBool,
          pregnancy,
        );
        setState(() {
          isLoading = false;
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
          if (e.code == 'network-request-failed') {
            _error = 'Please connect to internet and try again';
          } else {
            _error = e.message.toString();
          }
        });
      }
      if (userId == '') {
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
                      builder: (BuildContext context) => const Loginscreen(),
                    ),
                  );
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
    final phoneField = TextFormField(
      autofocus: false,
      controller: phonecontroller,
      keyboardType: TextInputType.phone,
      validator: (inputValue) {
        if (inputValue!.isEmpty) {
          return "Number field can't be empty!";
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
      ),
    );
    final emerg1Field = TextFormField(
      autofocus: false,
      controller: emerg1controller,
      keyboardType: TextInputType.phone,
      validator: (inputValue) {
        if (inputValue!.isEmpty) {
          return "Number field can't be empty!";
        }
        if (!_phoneRegex.hasMatch(inputValue)) {
          return "Please enter proper number";
        }

        return null;
      },
      onSaved: (value) {
        emerg1controller.text = value!;
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
      ),
    );
    final emerg2Field = TextFormField(
      autofocus: false,
      controller: emerg2controller,
      keyboardType: TextInputType.phone,
      validator: (inputValue) {
        if (inputValue!.isEmpty) {
          return "Number field can't be empty!";
        }
        if (!_phoneRegex.hasMatch(inputValue)) {
          return "Please enter proper number";
        }

        return null;
      },
      onSaved: (value) {
        emerg2controller.text = value!;
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
      ),
    );
    final emerg3Field = TextFormField(
      autofocus: false,
      controller: emerg3controller,
      keyboardType: TextInputType.phone,
      validator: (inputValue) {
        if (inputValue!.isEmpty) {
          return "Number field can't be empty!";
        }
        if (!_phoneRegex.hasMatch(inputValue)) {
          return "Please enter proper number";
        }

        return null;
      },
      onSaved: (value) {
        emerg3controller.text = value!;
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
      ),
    );
    final emerg4Field = TextFormField(
      autofocus: false,
      controller: emerg4controller,
      keyboardType: TextInputType.phone,
      validator: (inputValue) {
        if (inputValue!.isEmpty) {
          return "Number field can't be empty!";
        }
        if (!_phoneRegex.hasMatch(inputValue)) {
          return "Please enter proper number";
        }

        return null;
      },
      onSaved: (value) {
        emerg4controller.text = value!;
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
      ),
    );

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
      ),
    );
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
      ),
    );
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
      ),
    );
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
        hintText: "Emergency contact 4 Email Address",
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
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F9),
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
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              child: Image.asset('assets/images/logo.png'),
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            )),
                        const Padding(
                            padding: EdgeInsets.all(20),
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
                          padding: const EdgeInsets.all(5),
                          child: phoneField,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: emerg1Field,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: emerg1mailField),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: emerg2Field,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: emerg2mailField,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: emerg3Field,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: emerg3mailField,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: emerg4Field,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: emerg4mailField,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: pregnant,
                        ),
                        pregnantBool
                            ? Padding(
                                padding: const EdgeInsets.all(5),
                                child: pregTab,
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 20,
                            bottom: 5,
                          ),
                          child: loginbutton,
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
    phonecontroller.dispose();
    emerg1controller.dispose();
    emerg2controller.dispose();
    super.dispose();
  }
}
