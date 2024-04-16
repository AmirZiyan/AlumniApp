import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TalksBookedPage extends StatefulWidget {
  const TalksBookedPage({super.key});

  @override
  State<TalksBookedPage> createState() => _TalksBookedPageState();
}

class _TalksBookedPageState extends State<TalksBookedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talks'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('talks_booked')
                  .snapshots(),
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
                                  child: Text('Booked Email: ${data['Email']}'),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Event: ${data['event']}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Time : ${data['time']}'),
                                ),
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
          ),
        ],
      ),
    );
  }
}
