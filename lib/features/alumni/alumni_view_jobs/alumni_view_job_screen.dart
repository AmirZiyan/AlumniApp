import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        title: const Text('All Jobs',style: TextStyle(color: Colors.blue),),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
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
                                              'assets/images/jobs.png',
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
                                                  data['position']
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: GoogleFonts.aBeeZee(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Text(
                                                  data['company_name']
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: GoogleFonts.aBeeZee(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w200,
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
                                         "Salary : ${ data['salary']}"
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
                                     Row(
                                      
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                           "Phone :${data[ 'contact_number']}"
                                                .toString()
                                                .toUpperCase(),
                                            style: GoogleFonts.aBeeZee(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w200,
                                                fontSize: 12),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                           " Email :${data[ 'email']}"
                                                .toString()
                                                .toUpperCase(),
                                            style: GoogleFonts.aBeeZee(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w200,
                                                fontSize: 12),
                                          ),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 30, bottom: 20),
                                          child: Text(
                                           "Posted : ${ data['place']}"
                                                .toString()
                                                .toUpperCase(),
                                            style: GoogleFonts.aBeeZee(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w200,
                                                fontSize: 12),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 30, bottom: 20),
                                          child: Text(
                                            data['posted_by']
                                                .toString()
                                                .toUpperCase(),
                                            style: GoogleFonts.aBeeZee(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w200,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    )

                                 
                                  ],
                                ),
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
