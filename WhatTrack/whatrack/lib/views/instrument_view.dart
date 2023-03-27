import 'package:flutter/material.dart';

import '../constants/colors.dart';

class InstrumentPredictionScreen extends StatefulWidget {
  const InstrumentPredictionScreen({Key? key}) : super(key: key);

  @override
  State<InstrumentPredictionScreen> createState() =>
      _InstrumentPredictionScreenState();
}

class _InstrumentPredictionScreenState
    extends State<InstrumentPredictionScreen> {
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
                  'Instrument Prediction ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Do not know which instrument sound is that?,\n Upload and lets LETS FIND IT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'DMMono',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                const Image(
                  image: AssetImage('assets/images/instrumentnew.jpg'),
                ),
                const SizedBox(height: 30),
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
