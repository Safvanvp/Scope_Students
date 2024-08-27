import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scopeindia_student/widgets/text_styles.dart';

class StudentsList extends StatefulWidget {
  const StudentsList({super.key});

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff071e67),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: Text(
          "Students List",
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Students").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("$Error");
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    return Container(
                      padding: EdgeInsets.only(
                          top: 10, right: 10, bottom: 10, left: 10),
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[400]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name : " + data["Name"],
                            style: AppWidget.semiboldTextFieldstyle(),
                          ),
                          Text(
                            "Phone : " + data["Phone"],
                            style: AppWidget.semiboldTextFieldstyle(),
                          ),
                          Text(
                            "DOB : " + data["Dob"],
                            style: AppWidget.semiboldTextFieldstyle(),
                          ),
                          Text(
                            "Gender : " + data["Gender"],
                            style: AppWidget.semiboldTextFieldstyle(),
                          ),
                          Text(
                            "Mail : " + data["Gmail"],
                            style: AppWidget.semiboldTextFieldstyle(),
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}
