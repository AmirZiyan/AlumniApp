import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_slide_to_act/gradient_slide_to_act.dart';

class FundRaisingPage extends StatefulWidget {
  const FundRaisingPage({super.key});

  @override
  State<FundRaisingPage> createState() => _FundRaisingPageState();
}

class _FundRaisingPageState extends State<FundRaisingPage> {
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fund Raising'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('funds').snapshots(),
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
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Student Name :${data['name']}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Class :${data['class']}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'Amount Needed :${data['amount_needed']}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Reason :${data['reason']}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Account no: :${data['ac_no']}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Age:${data['age']}'),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        showBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              color: Colors.transparent,
                                              height: height * 0.6,
                                              width: width,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(20.0),
                                                    child: TextField(
                                                      controller:
                                                          amountController,
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              'Enter Amount',
                                                          border:
                                                              OutlineInputBorder()),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.8,
                                                    child: GradientSlideToAct(
                                                      width: width * 0.8,
                                                      textStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15),
                                                      backgroundColor:
                                                          const Color(
                                                              0Xff172663),
                                                      onSubmit: () async {
                                                        if (amountController
                                                            .text.isNotEmpty) {
                                                          try {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'fund_received')
                                                                .add({
                                                              'Donated_By':
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .email
                                                                      .toString(),
                                                              'Account_no':
                                                                  '${data['ac_no']}',
                                                              'Amount':
                                                                  '${amountController.text}',
                                                              'Amount_Needed_Person':
                                                                  '${data['name']}'
                                                            }).then((value) =>
                                                                    Navigator.pop(
                                                                        context));
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                content: Text(
                                                                    'Paid Successfully'),
                                                              ),
                                                            );
                                                          } catch (e) {
                                                            log(e.toString());
                                                          }
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                  'Please Enter An Amount'),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      gradient:
                                                          const LinearGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                        colors: [
                                                          Color(0xff0da6c2),
                                                          Color(0xff0E39C6),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.1,
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const Text('Sponsor Now'),
                                    ),
                                    // TextButton(
                                    //   onPressed: () {},
                                    //   child: const Text('Call Student'),
                                    // )
                                  ],
                                )
                              ],
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
          )
        ],
      ),
    );
  }
}
