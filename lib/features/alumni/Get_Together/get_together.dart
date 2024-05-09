import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetTogetherPage extends StatefulWidget {
  const GetTogetherPage({super.key});

  @override
  _GetTogetherPageState createState() => _GetTogetherPageState();
}

class _GetTogetherPageState extends State<GetTogetherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Together'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Get_together')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No Data'),
                  );
                }
                final docs = snapshot.data!.docs;
                return ListView.builder(
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
                              child: Text('Batch: ${data['batch']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Venue: ${data['venue']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Date: ${data['date']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Time: ${data['time']}'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection('booked_getTogether')
                                      .add({
                                    'Email': FirebaseAuth
                                        .instance.currentUser!.email
                                        .toString(),
                                    'batch': '${data['batch']}',
                                    'venue': '${data['venue']}',
                                  });
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Seat Booked'),
                                        content: const Text(
                                            'Your seat has been booked!'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } catch (e) {
                                  log(e.toString());
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: Text(
                                            'Failed to book seat: ${e.toString()}'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text('Book Now'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
