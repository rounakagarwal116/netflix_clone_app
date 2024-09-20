import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_clone_app/authentication/login_page.dart';
import 'package:netflix_clone_app/authentication/signup_page.dart';
import 'package:netflix_clone_app/widgets/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        "assets/netflix.json",
      ),
    );
  }
}