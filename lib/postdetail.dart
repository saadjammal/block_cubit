// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:block_cubit/databasehelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Postdetail extends StatefulWidget {
  @override
  State<Postdetail> createState() => _CreatePostState();
}

class _CreatePostState extends State<Postdetail> {
final Stream<QuerySnapshot> usersStream =
postCollection.snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                  shrinkWrap: true,
                  // itemCount: snapshot.data!.docs.length,
                  // itemBuilder: ((context, index) {
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    print(Text(data['imageUrl']));
                    return Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.network(data['imageUrl']),
                      ),
                    );
                  }).toList());
              //     return Text('nodata');
              //   }),
              // );
            }),

        // SizedBox(
        //   height: 10,
        // ),
        // ElevatedButton(
        //   onPressed: () {},
        //   child: const Text('Delete Post'),
        // ),
      ),
    );
  }
}
