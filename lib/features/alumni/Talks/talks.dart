// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class TalksPage extends StatefulWidget {
  const TalksPage({
    super.key,
  });

  @override
  State<TalksPage> createState() => _TalksPageState();
}

class _TalksPageState extends State<TalksPage> {
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Talks'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Talks').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.blue.shade500,
                                    Colors.blue.shade400,
                                    Colors.blue.shade300,
                                    Colors.blue.shade200,
                                  ]),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 29, horizontal: 20),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.asset(
                                            'assets/images/talks.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Text(
                                                "Title:  ${data['title']}"
                                                    .toString()
                                                    .toUpperCase(),
                                                style: GoogleFonts.aBeeZee(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Text(
                                                "Speaker: ${data['speaker']}"
                                                    .toString()
                                                    .toUpperCase(),
                                                style: GoogleFonts.aBeeZee(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          "${data['description']}"
                                              .toString()
                                              .toUpperCase(),
                                          style: GoogleFonts.aBeeZee(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          "Date :${data['date']}"
                                              .toString()
                                              .toUpperCase(),
                                          style: GoogleFonts.aBeeZee(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 12),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Time :${data['time']}"
                                            .toString()
                                            .toUpperCase(),
                                        style: GoogleFonts.aBeeZee(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w200,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      TextButton(
                                          onPressed: () async {
                                            try {
                                              await FirebaseFirestore.instance
                                                  .collection('talks_booked')
                                                  .add({
                                                'Email': FirebaseAuth
                                                    .instance.currentUser!.email
                                                    .toString(),
                                                'event': '${data['title']}',
                                                'time': '${data['time']}'
                                              }).then((value) => showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Seat Booked'),
                                                            content: const Text(
                                                                'Your seat has been booked!'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'OK'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ));
                                            } catch (e) {
                                              log(e.toString());
                                            }

                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title:
                                                      const Text('Seat Booked'),
                                                  content: const Text(
                                                      'Your seat has been booked!'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            'Book Now',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    ],
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Expanded(
                    child: Center(
                      child: Text('No Data'),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
