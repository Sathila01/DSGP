import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MusicGenreScreen extends StatefulWidget {
  const MusicGenreScreen({Key? key}) : super(key: key);

  @override
  State<MusicGenreScreen> createState() => _MusicGenreScreenState();
}

class _MusicGenreScreenState extends State<MusicGenreScreen> {
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
            image: AssetImage('assets/images/backgroundDark.png'),
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
                  'Music Genre Classification',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Just listening to music,\ncheck the genre of it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'DMMono',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Image(
                  image: AssetImage('assets/images/musiclisten.jpg'),
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
