import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whatrack/shared/ipAddress.dart';
import '../constants/colors.dart';

class MajorMinorScreen extends StatefulWidget {
  const MajorMinorScreen({Key? key}) : super(key: key);

  @override
  State<MajorMinorScreen> createState() => _MajorMinorScreenState();
}

class _MajorMinorScreenState extends State<MajorMinorScreen> {
  late bool _isUploading;
  String output = "";

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
          .ref('chord')
          // .child(
          //     _filePath.substring(_filePath.lastIndexOf('/'), _filePath.length))
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
    var url = Uri.http('${IP_ADDRESS}', 'chord');
    var response =
        await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    setState(() {
      output = response.body;
    });
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
                const SizedBox(height: 10),
                const Text(
                  'Major-Minor Chord \n Identification',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Need to know whether your chord is Major or Minor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'DMMono',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                const Image(
                  image: AssetImage('assets/images/guitar3.jpg'),
                ),
                const SizedBox(height: 3),
                ElevatedButton(
                  onPressed: () {
                    _test();
                  },
                  child: const Text('Chose Audio File'),
                ),
                const SizedBox(height: 3),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      output = "Loading...";
                    });
                    _getFileInput();
                    // sendFileToModel();
                  },
                  child: const Text('Predict'),
                ),
                const SizedBox(height: 5),
                Text(
                  output != "" ? output : "",
                  textAlign: TextAlign.center,
                  style: output == "Loading..."
                      ? const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )
                      : const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
