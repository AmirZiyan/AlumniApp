import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_services_with_bloc/features/start_up_page/start_page.dart';
import 'package:flutter/material.dart';

class StudentJobsPage extends StatefulWidget {
  const StudentJobsPage({super.key});

  @override
  State<StudentJobsPage> createState() => _StudentJobsPageState();
}

class _StudentJobsPageState extends State<StudentJobsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then(
                    (value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StartPage(),
                        ),
                        (route) => false),
                  );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text('Call HR'),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child:
                                            const Text('Apply Through Email'),
                                      ),
                                    ],
                                  )
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
