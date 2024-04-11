import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AlumniViewJob extends StatefulWidget {
  const AlumniViewJob({super.key});

  @override
  State<AlumniViewJob> createState() => _AlumniViewJobState();
}

class _AlumniViewJobState extends State<AlumniViewJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Jobs'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
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
                          child: GestureDetector(
                            onLongPress: () {
                              // delete data
                              FirebaseFirestore.instance
                                  .collection('jobs')
                                  .doc(data.id)
                                  .delete()
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Job Details deleted"),
                                  ),
                                );
                              }).catchError((error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Failed to delete item"),
                                  ),
                                );
                              });
                            },
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Company Name :${data['company_name']}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Text('Position :${data['position']}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Place :${data['place']}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Salary :${data['salary']}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Text('Apply Email :${data['email']}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Hr Contact Number:${data['contact_number']}'),
                                  ),
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
          )
        ],
      ),
    );
  }
}
