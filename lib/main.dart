import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String studentName, studentID, dob, hometown;

  getStudentName(name) {
    this.studentName = name;
  }

  getStudentID(stdID) {
    this.studentID = stdID;
  }

  getStudentDOB(dob) {
    this.dob = dob;
  }

  getStudentHometown(ht) {
    this.hometown = ht;
  }

  createData() {
    print("createData() entered!");

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Students").doc(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "dob": dob,
      "hometown": hometown
    };
    documentReference.set(students).whenComplete(() {
      print("$studentName Created");
    });
  }

  readData() {
    print("Pressed Read!");

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Students").doc(studentName);

    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data()["studentName"]);
      print(datasnapshot.data()["studentID"]);
      print(datasnapshot.data()["dob"]);
      print(datasnapshot.data()["hometown"]);
    });
  }

  updateData() {
    //print("Pressed Update");
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Students").doc(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "dob": dob,
      "hometown": hometown
    };
    documentReference.set(students).whenComplete(() {
      print("$studentName Updated");
    });
  }

  deleteData() {
    //print("Pressed Delete");
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Students").doc(studentName);

    documentReference.delete().whenComplete(() {
      print("$studentName deleted");
    });
  }

  //TextEditingController dateCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Student Info"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Name",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String name) {
                    getStudentName(name);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Student ID",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String stdID) {
                    getStudentID(stdID);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Date of Birth",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String dob) {
                    getStudentDOB(dob);
                  },
                ),
                //
                // child: TextFormField(
                //   controller: dateCtl,
                //   decoration: InputDecoration(
                //     labelText: "Date of birth",
                //     hintText: "Ex. Insert your dob",
                //   ),
                //   onTap: () async {
                //     DateTime date = DateTime(1900);
                //     FocusScope.of(context).requestFocus(new FocusNode());

                //     date = await showDatePicker(
                //         context: context,
                //         initialDate: DateTime.now(),
                //         firstDate: DateTime(1900),
                //         lastDate: DateTime(2100));

                //     dateCtl.text = date.toIso8601String();
                //   },
                //   onChanged: (String dob) {
                //     getStudentDOB(dateCtl.text);
                //   },
                // ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Hometown",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String hometown) {
                    getStudentHometown(hometown);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        createData();
                      },
                      child: Text("Create"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        shadowColor: Colors.red,
                        elevation: 5,
                      )),
                  ElevatedButton(
                      onPressed: () {
                        readData();
                      },
                      child: Text("Read"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        onPrimary: Colors.white,
                        shadowColor: Colors.red,
                        elevation: 5,
                      )),
                  ElevatedButton(
                      onPressed: () {
                        updateData();
                      },
                      child: Text("Update"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan,
                        onPrimary: Colors.white,
                        shadowColor: Colors.red,
                        elevation: 5,
                      )),
                  ElevatedButton(
                    onPressed: () {
                      deleteData();
                    },
                    child: Text("Delete"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      onPrimary: Colors.white,
                      shadowColor: Colors.red,
                      elevation: 5,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Expanded(child: Text("Name")),
                    Expanded(child: Text("Student_ID")),
                    Expanded(child: Text("Date of Birth")),
                    Expanded(child: Text("Hometown")),
                  ],
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Students")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data.docs[index];
                          return Row(
                            children: [
                              Expanded(
                                child: Text(documentSnapshot["studentName"]),
                              ),
                              Expanded(
                                child: Text(documentSnapshot["studentID"]),
                              ),
                              Expanded(
                                child: Text(documentSnapshot["dob"]),
                              ),
                              Expanded(
                                child: Text(documentSnapshot["hometown"]),
                              ),
                            ],
                          );
                        });
                  }
                },
              )
            ],
          ),
        ));
  }
}
