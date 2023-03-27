import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatrack/views/aboutus_view.dart';
import 'package:whatrack/views/forgot.dart';
import 'package:whatrack/views/home_view.dart';
import 'package:whatrack/views/instrument_view.dart';
import 'package:whatrack/views/login_view.dart';
import 'package:whatrack/views/major_minor_chord.dart';
import 'package:whatrack/views/music_genre_view.dart';
import 'package:whatrack/views/profile_view.dart';
import 'package:whatrack/views/register_view.dart';
import 'package:whatrack/views/splash_view.dart';

import 'models/userModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}



// UserModel _user;
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "WhatTrack",
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/musicGenre': (context) => const MusicGenreScreen(),
        '/major-minor': (context) => const MajorMinorScreen(),
        '/aboutUs': (context) => const AboutUs(),
        // '/profile': (context) => const Profile(),
        '/instrument': (context) => const InstrumentPredictionScreen(),
        '/forgot': (context) => const ForgotPassword(),
      },
    );
  }
}
