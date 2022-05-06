import 'dart:io';

import 'package:block_cubit/postdetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  firebase_storage.Reference imageRef = firebase_storage
      .FirebaseStorage.instance
      .ref('Images / ${DateTime.now()}');

  File? image;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (image != null) {
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } else {
      return print('Image not selected ');
    }
  }

  CreatePost() async {
    try {
      UploadTask uploadTask = imageRef.putFile(image!);
      await Future.value(uploadTask);
      var imageUrl = await imageRef.getDownloadURL();
      var url = imageUrl.toString();
      FirebaseFirestore.instance.collection('post').add({
        'imageUrl': imageUrl,
      });
      //     .then((value) {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => RoleScreen()),
      //   );
      // });
      return url;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cubit'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: image == null
                      ? Container(
                          height: 90.0, width: 90.0,
                          // margin: EdgeInsets.only(right: 220),
                          padding: EdgeInsets.all(2),
                          // alignment: Alignment.center,
                          decoration:
                              new BoxDecoration(color: Colors.blueAccent),
                          child: Center(
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt),
                              iconSize: 70,
                              onPressed: pickImage,
                            ),
                          ),
                        )
                      : Container(
                          height: 90.0,
                          width: 90.0,
                          child: Image.file(image!),
                        ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  CreatePost();
                });
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Postdetail()));
              },
              child: const Text('Create Post'),
            ),
          ],
        ),
      ),
    );
  }
}
