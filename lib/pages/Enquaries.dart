import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Enquarys extends StatefulWidget {
  const Enquarys({super.key});

  @override
  State<Enquarys> createState() => _EnquarysState();
}

class _EnquarysState extends State<Enquarys> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Enquiries",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold)),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Color(0xff071e67),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("EnquiryRequest")
              .snapshots(),
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
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, right: 20, left: 20),
                      child: Material(
                        elevation: 15.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 15.0, left: 20.0, bottom: 15, right: 15.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 241, 42, 78),
                                // Color.fromARGB(255, 234, 204, 218),
                                Color.fromARGB(222, 204, 0, 255)
                              ]),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Enquiry",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                Divider(),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text("Name :  " + data["Name"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text("Gender :  " + data["Gender"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text("Mail :  " + data["Mail"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text("Date Of Birth :  " + data["DateOfBirth"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text("Course :  " + data["Course"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text("Phone :  +91  " + data["Phone"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 20.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    DeleteEnquiry(
                                        snapshot.data!.docs[index].id);
                                  },
                                  child: Center(
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        decoration: BoxDecoration(
                                            color: Color(0xfffe8f33),
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Text(
                                          "Done",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ]),
                        ),
                      ),
                    );
                  });
            }
          },
        ));
  }

  Future<void> DeleteEnquiry(String id) async {
    await FirebaseFirestore.instance
        .collection("EnquiryRequest")
        .doc(id)
        .delete();
  }
}
