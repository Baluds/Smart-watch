// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  final TextEditingController emergencycontroller1 = TextEditingController();
  final TextEditingController emergencycontroller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //name
    final name = Container(
        height: 50,
        width: 312,
        color: Colors.white,
        child: TextFormField(
          autofocus: false,
          controller: namecontroller,
          keyboardType: TextInputType.emailAddress,
          //validator: () {},
          onSaved: (value) {
            emailcontroller.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: "Name",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ));

    //emailfield
    final emailField = Container(
        height: 50,
        width: 312,
        color: Colors.white,
        child: TextFormField(
          autofocus: false,
          controller: emailcontroller,
          keyboardType: TextInputType.emailAddress,
          //validator: () {},
          onSaved: (value) {
            emailcontroller.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: "Email Address",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ));
    final phoneField = Container(
        height: 50,
        width: 312,
        color: Colors.white,
        child: TextFormField(
          autofocus: false,
          controller: phonecontroller,
          keyboardType: TextInputType.phone,
          //validator: () {},
          onSaved: (value) {
            emailcontroller.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: "Phone Number",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ));
    final addressField = Container(
        height: 50,
        width: 312,
        color: Colors.white,
        child: TextFormField(
          autofocus: false,
          controller: addresscontroller,
          keyboardType: TextInputType.streetAddress,
          //validator: () {},
          onSaved: (value) {
            emailcontroller.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: "Address",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ));
    final emergencyfield1 = Container(
        height: 50,
        width: 312,
        color: Colors.white,
        child: TextFormField(
          autofocus: false,
          controller: emergencycontroller1,
          keyboardType: TextInputType.phone,
          //validator: () {},
          onSaved: (value) {
            emailcontroller.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: "Emergency Contact 1",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ));
    final emergencyfield2 = Container(
        height: 50,
        width: 312,
        color: Colors.white,
        child: TextFormField(
          autofocus: false,
          controller: emergencycontroller2,
          keyboardType: TextInputType.phone,
          //validator: () {},
          onSaved: (value) {
            emailcontroller.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: "Emergency Contact 2",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
      onPressed: () {},
      child: const Text(
        'Submit',
      ),
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                        child: Text(
                          'A little more about you,\n          Balachandra',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset('assets/images/profile_pic.png')),
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
                      child: addressField,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: emergencyfield1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: emergencyfield2,
                    ),
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
}
