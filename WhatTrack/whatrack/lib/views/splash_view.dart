import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatrack/constants/colors.dart';

late String? finalEmail = "";

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    getValidationData().whenComplete(() async {
      Timer(
          Duration(seconds: 1),
          () => finalEmail == null
              ? Navigator.pushReplacementNamed(context, '/login')
              : Navigator.pushReplacementNamed(context, '/home'));
    });
    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    finalEmail = sharedPreferences.getString('email');
    print(finalEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: CustomColors.blackPurple,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/images/backgroundDark.png'),
        //     fit: BoxFit.fill,
        //   ),
        // ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Image.asset('assets/images/logo_square.png'),
              ),
              const SizedBox(height: 30),
              const Text(
                'WhatTrack',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'DMMono',
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 100),
              const Text(
                'Where music connects with You',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
