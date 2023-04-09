import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:whatrack/views/reccomend.dart';

import '../constants/colors.dart';
import '../shared/ipAddress.dart';

class MusicGenreScreen extends StatefulWidget {
  const MusicGenreScreen({Key? key}) : super(key: key);

  @override
  State<MusicGenreScreen> createState() => _MusicGenreScreenState();
}

class _MusicGenreScreenState extends State<MusicGenreScreen> {
  final TextEditingController _genreType = TextEditingController();

  late bool _isUploading;
  String output = "";
  bool is_recommend = false;

  late String _filePath = "";

  @override
  void initState() {
    super.initState();
    _isUploading = false;
  }

  _test() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    PlatformFile file = result.files.first;
    _filePath = file.path!;
    print('File Name: ${file.name}');
    print('File Size: ${file.size}');
    print('File Extension: ${file.extension}');
    print('File Path: ${file.path}');
  }

  Future<void> _getFileInput() async {
    print(_filePath);
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    setState(() {
      _isUploading = true;
    });
    try {
      await firebaseStorage
          .ref('genre')
          .child("audFile.wav")
          .putFile(File(_filePath));
      // .whenComplete(() => sendFileToModel());
      // _onUploadComplete();
      sendFileToModel();
    } catch (error) {
      print('Error occured while uplaoding to Firebase ${error.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error occured while uplaoding'),
        ),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  sendFileToModel() async {
    var url = Uri.http('${IP_ADDRESS}', 'genre');
    try {
      var response =
          await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      setState(() {
        output = response.body;
      });
    } catch (e) {
      setState(() {
        output = "";
      });
      toast("Check your Connection");
      print(e);
    }
  }

  void toast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.black,
      fontSize: 16,
      backgroundColor: Colors.grey[200],
    );
  }

  List _items = [];

  // Fetch content from the json file
  Future<void> readJson(String a) async {
    // final String response = await rootBundle.loadString(a);
    final data = await json.decode(a);
    setState(() {
      _items = data;
    });
  }

  _launchURL(url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  String rec_output = "";
  sendToRecommend(String type) async {
    var url = Uri.http('${IP_ADDRESS}', 'recommend/${type}');
    var response =
        await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    setState(() {
      rec_output = response.body;
    });

    if (rec_output != "") {
      if (rec_output == "Error") {
        toast("${type} is not existing");
        setState(() {
          _items = [];
        });
      } else {
        readJson(response.body);
      }
    } else {
      toast("Network Error");
    }
  }

  Future<void> recommend(String genreType) async {
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MusicRecommendation(
              genreType: genreType,
            )));
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
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundLight.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Column(
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
                  const SizedBox(height: 10),
                  const Text(
                    'Just listening to music,\ncheck the genre of it.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'DMMono',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  // const SizedBox(height: 5),
                  const Image(
                    image: AssetImage('assets/images/musiclisten.jpg'),
                  ),
                  // const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      _test();
                    },
                    child: const Text('Chose Audio File'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // _test();
                      setState(() {
                        output = "Loading...";
                      });
                      _getFileInput();
                      // sendFileToModel();
                    },
                    child: const Text('Predict'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    output != "" ? output : "",
                    textAlign: TextAlign.center,
                    style: output == "Loading..."
                        ? const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          )
                        : const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // output == "" ? toast("First Predict Genre") : recommend();

          try {
            print(output);
            // genreType != "" ? print("have") : print("no");
            output != "" ? recommend(output) : toast("First Predict Genre");
          } catch (e) {
            print(e);
          }
        },
        label: const Text('Recommend Music'),
        icon: const Icon(Icons.music_note_rounded),
        backgroundColor: Colors.purple[400],
      ),
    );
  }
}
