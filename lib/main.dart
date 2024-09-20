import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Netflix Clone",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white, fontSize: 24),
              bodyMedium: TextStyle(color: Colors.white, fontSize: 20),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
                .copyWith(surface: Colors.black),
            fontFamily: GoogleFonts.ptSans().fontFamily),
        home: const SplashScreen());
  }
}
