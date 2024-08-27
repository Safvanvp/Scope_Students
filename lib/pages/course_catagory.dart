import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CourseCatagory extends StatefulWidget {
  String branch;
  CourseCatagory({required this.branch});

  @override
  State<CourseCatagory> createState() => _CourseCatagoryState();
}

class _CourseCatagoryState extends State<CourseCatagory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff071e67),
        appBar: AppBar(
          title: Text(
            widget.branch,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(widget.branch)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("$Error");
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      return Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          data["Course1"],
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      );
                    });
              }
            }));
  }
}
