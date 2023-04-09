// import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/colors.dart';
import 'dart:io';

import '../shared/ipAddress.dart';

class InstrumentPredictionScreen extends StatefulWidget {
  const InstrumentPredictionScreen({Key? key}) : super(key: key);

  @override
  State<InstrumentPredictionScreen> createState() =>
      _InstrumentPredictionScreenState();
}

class _InstrumentPredictionScreenState
    extends State<InstrumentPredictionScreen> {
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
          .ref('instruments')
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
    var url = Uri.http('${IP_ADDRESS}', 'instruments');
    var response =
        await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
    // output = await http.read(Uri.http('192.168.8.155:5000', 'api'));
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
                const SizedBox(height: 20),
                const Text(
                  'Instrument Prediction ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Do not know which instrument sound is that?,\n Upload and lets LETS FIND IT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'DMMono',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                const Image(
                  image: AssetImage('assets/images/instrumentnew.jpg'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    _test();
                  },
                  child: const Text('Chose Audio File',
                  textAlign: TextAlign.center,),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    // _test();
                    setState(() {
                      output = "Loading...";
                    });
                    _getFileInput();
                    // sendFileToModel();
                  },
                  child: const Text('Predict',
                  textAlign: TextAlign.center,),
                ),
                const SizedBox(height: 10),
                Text(output != "" ? output : "",
                    textAlign: TextAlign.center,
                    style: output == "Loading..."
                        ? const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          )
                        : const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          )
                    // const TextStyle(
                    //   fontSize: 30,
                    //   color: Colors.white,
                    // ),
                    ),
                // ElevatedButton(
                //   onPressed: () {
                //     _getFileInput();
                //   },
                //   child: const Text('Input Audio File'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
