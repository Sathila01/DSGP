import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../constants/colors.dart';
import '../shared/ipAddress.dart';

class MusicRecommendation extends StatefulWidget {
  const MusicRecommendation({Key? key, required this.genreType})
      : super(key: key);
  final String genreType;
  @override
  State<MusicRecommendation> createState() => _MusicRecommendationState();
}

class _MusicRecommendationState extends State<MusicRecommendation> {
  final TextEditingController _genreType = TextEditingController();

  void toast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.black,
      fontSize: 16,
      backgroundColor: Colors.grey[200],
    );
  }

  void initState() {
    super.initState();
    try {
      print(widget.genreType);
      // genreType != "" ? print("have") : print("no");
      widget.genreType != ""
          ? sendToRecommend(widget.genreType)
          : toast("Please enter genre type");
    } catch (e) {
      print(e);
    }
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
    // const url = 'https://flutter.io';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  String output = "";
  sendToRecommend(String type) async {
    var url = Uri.http('${IP_ADDRESS}', 'recommend/${type}');
    var response =
        await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    setState(() {
      output = response.body;
    });

    // output != ""
    //     ? output == "Error"
    //         ? toast("${type} is not existing")
    //         : readJson(response.body)
    //     : toast("Error");

    if (output != "") {
      if (output == "Error") {
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
              const SizedBox(height: 30),
              const Text(
                'Music Recommendation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              _items.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          return Card(
                            key: ValueKey(_items[index]["id"]),
                            margin: const EdgeInsets.all(10),
                            color: Colors.purple.shade200,
                            child: ListTile(
                                // leading: Text(_items[index]["id"]),
                                title: Text(_items[index]["name"]),
                                // subtitle: Text(_items[index]["url"]),
                                onTap: () {
                                  _launchURL(_items[index]["url"]);
                                }),
                          );
                        },
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
