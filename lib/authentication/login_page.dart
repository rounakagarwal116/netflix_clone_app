import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:netflix_clone_app/authentication/forgot_password.dart';
import 'package:netflix_clone_app/authentication/google_signin.dart';
import 'package:netflix_clone_app/authentication/signup_page.dart';
import 'package:netflix_clone_app/utils/utils.dart';
import 'package:netflix_clone_app/widgets/bottom_nav_bar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LogInState();
}

class _LogInState extends State<Login> {
  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      var a=await user?.getIdToken(true);
      inspect(user);
    });
  }

  String email = "", password = "";

  TextEditingController mailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const BottomNavBar()));
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: scaffoldColor,
            content: Text(
              "Email or Password Entered is Wrong",
              style: TextStyle(fontSize: 18.0),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 35, 35, 36),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter E-mail';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                      controller: mailcontroller,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white70,
                            size: 18.0,
                          ),
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(
                              color: Color(0xFFb2b7bf), fontSize: 18.0)),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 35, 35, 36),
                    ),
                    child: TextFormField(
                      controller: passwordcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.key_sharp,
                            color: Colors.white70,
                            size: 18,
                          ),
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Color(0xFFb2b7bf), fontSize: 18.0)),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          email = mailcontroller.text;
                          password = passwordcontroller.text;
                        });
                      }
                      userLogin();
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 30.0),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 241, 36, 36),
                        ),
                        child: const Center(
                            child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500),
                        ))),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPassword()));
            },
            child: const Text("Forgot Password?",
                style: TextStyle(
                    color: Color.fromARGB(255, 172, 173, 177),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500)),
          ),
          const SizedBox(
            height: 40.0,
          ),
          const Text(
            "or Login with",
            style: TextStyle(
                color: Color.fromARGB(255, 172, 173, 177),
                fontSize: 22.0,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  GoogleSignInClasss().signInWithGoogle(context);
                },
                child: Image.asset(
                  "assets/google.png",
                  height: 45,
                  width: 45,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?",
                  style: TextStyle(
                      color: Color.fromARGB(255, 172, 173, 177),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                width: 5.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                child: const Text(
                  "SignUp",
                  style: TextStyle(
                      color: Color.fromARGB(255, 241, 36, 36),
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
