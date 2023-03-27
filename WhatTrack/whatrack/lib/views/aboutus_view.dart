import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

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
                const Text(
                  'ABOUT US',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                Text('Welcome to our About Us page! We are a group of second-year data science students who have come '
                    'together to work on an exciting project focused on music information classification using machine learning algorithms . '
                    'Our team of four developed this app with three main ML components which are prediction of music genres, instrument prediction and major/minor key prediction. '
                    'We were guided and supervised by Ms.Sachinthani Perera who is a present lecturer. ',
                  textAlign: TextAlign.justify,
                  style:GoogleFonts.dmMono(
                    fontSize: 12.5,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text('OUR TEAM',textAlign: TextAlign.center,style: GoogleFonts.dmMono(fontSize: 30,color: Colors.white),),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(10),
                    color: const Color(0xFFB298BE),
                  ),
                  padding: const EdgeInsets.only(top: 8, left: 10, bottom: 7,right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 30.0,
                            backgroundImage: AssetImage('assets/profile1.png'),
                          ),
                          const SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'John Doe',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                'Software Engineer',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                              // TextButton(
                              //   onPressed: () => launch('https://github.com/johndoe'),
                              //   child: Text(
                              //     'https://github.com/johndoe',
                              //     style: TextStyle(
                              //       fontSize: 16.0,
                              //       color: Colors.blue,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 30.0,
                            backgroundImage: AssetImage('assets/images/Ishan_profile_Pic.png'),
                          ),
                          const SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ishan Fernando',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                '',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                              // TextButton(
                              //   onPressed: () => launch('https://github.com/janesmith'),
                              //   child: Text(
                              //     'https://github.com/janesmith',
                              //     style: TextStyle(
                              //       fontSize: 16.0,
                              //       color: Colors.blue,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 30.0,
                            backgroundImage: AssetImage('assets/profile3.png'),
                          ),
                          const SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Bob Johnson',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                'Machine Learning Engineer',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                              // TextButton(
                              //   onPressed: (){} ,
                              //   child: Text(
                              //     'https://github.com/bobjohnson',
                              //     style: TextStyle(
                              //       fontSize: 16.0,
                              //       color: Colors.blue,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0,),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 30.0,
                            backgroundImage: AssetImage('assets/profile3.png'),
                          ),
                          const SizedBox(width: 16.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Thareen Ranuja',
                                style: GoogleFonts.istokWeb(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,),
                              ),
                              Text('Email: rhhhtht@gmail.com',
                                style: GoogleFonts.istokWeb(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),)
                            ],
                          )
                        ],
                      )

                    ],
                  ),
                ),

              ],
            ),



          ),
        ),




      ),




    );


  }
}
