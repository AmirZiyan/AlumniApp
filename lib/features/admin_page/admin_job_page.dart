import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminJobPage extends StatefulWidget {
  const AdminJobPage({super.key});

  @override
  State<AdminJobPage> createState() => _AdminJobPageState();
}

class _AdminJobPageState extends State<AdminJobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Jobs'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No Jobs Available'));
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onLongPress: () => _deleteJob(document.id),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildText('Company Name:', data['company_name']),
                          _buildText('Position:', data['position']),
                          _buildText('Place:', data['place']),
                          _buildText('Salary:', data['salary']),
                          _buildText('Apply Email:', data['email']),
                          _buildText('HR Contact Number:', data['contact_number']),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }

  Widget _buildText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('$label $value'),
    );
  }

  void _deleteJob(String documentId) {
    FirebaseFirestore.instance
        .collection('jobs')
        .doc(documentId)
        .delete()
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Job details deleted"),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to delete job details"),
        ),
      );
    });
  }
}
