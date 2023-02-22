// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary/screen/homescreen.dart';
import 'package:flutter/material.dart';

class NoteEditor extends StatefulWidget {
  const NoteEditor({Key? key}) : super(key: key);

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  CollectionReference note = FirebaseFirestore.instance.collection('Notes');
  TextEditingController titleControler = TextEditingController();
  TextEditingController contentControler = TextEditingController();
  TextEditingController idControler = TextEditingController();

  String date = DateTime.now().toString();
  final key = GlobalKey<FormState>();

  void clear() {
    titleControler.clear();
    contentControler.clear();
    idControler.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Add a New Note"),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: key,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: idControler,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter Unique ID";
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Ente ID"),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: titleControler,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter title";
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Enter Title"),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                date,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),

              //content
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: contentControler,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please Enter content";
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Enter Description"),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              FloatingActionButton.extended(
                onPressed: addUser,
                label: Text("Save"),
                icon: Icon(Icons.save),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void addUser() async {
    // Call the user's CollectionReference to add a new user
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      db.collection("Notes").doc().set({
        "Title": titleControler.text.trim(),
        "Date": date,
        "Content": contentControler.text.trim(),
        "Id": idControler.text.trim(),
      });
    } catch (e) {
      print("error");
    }
  }
}
