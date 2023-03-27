import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MajorMinorScreen extends StatefulWidget {
  const MajorMinorScreen({Key? key}) : super(key: key);

  @override
  State<MajorMinorScreen> createState() => _MajorMinorScreenState();
}

class _MajorMinorScreenState extends State<MajorMinorScreen> {
  void _getFileInput() {
    /// TODO: process file upload
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.appBarPurple,

        /// Logo
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Image(
            image: AssetImage(
              'assets/images/logo_circle.png',
            ),
          ),
        ),

        /// Title
        title: const Text(
          'WhatTrack',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: 'DMMono',
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundLight.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Major-Minor Chord \n Identification',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Need to know whether your chord is Major or Minor,\nDrop the file.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'DMMono',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                const Image(
                  image: AssetImage('assets/images/instrumentPrediction.jpg'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _getFileInput();
                  },
                  child: const Text('Input Audio File'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
