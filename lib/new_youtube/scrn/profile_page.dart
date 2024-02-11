import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spendwise/new_youtube/database.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key, required this.userId});
  final userId;

  final db = Db();

  @override
  Widget build(BuildContext context) {
    // final userStream = db.getDoc();
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Profile'),
      //   centerTitle: true,
      //   elevation: 0.0,
      // ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: db.getDoc(userId: userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            } else if (snapshot.hasError) {
              return const Text('An Error occurred');
            } else if (!snapshot.hasData) {
              return const Text('Counld not get data');
            }

            var data = snapshot.data!.data() as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Welcome to Your Profile',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        height: 50.0,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Row(
                            children: [
                              const Text(
                                'Username: ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                "${data['userName']}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        height: 50.0,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Row(
                            children: [
                              const Text(
                                'Phone Number: ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                "${data['phone']}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        height: 50.0,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Row(
                            children: [
                              const Text(
                                'Email:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                "${data['email']}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        )),
                    //
                    const SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                            color: Colors.red[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
