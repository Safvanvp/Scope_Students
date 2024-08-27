import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlacementCell extends StatefulWidget {
  const PlacementCell({super.key});

  @override
  State<PlacementCell> createState() => _PlacementCellState();
}

class _PlacementCellState extends State<PlacementCell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff071e67),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("placements").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("$Error");
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  child: Material(
                    elevation: 15.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 15.0, left: 20.0, bottom: 15, right: 15.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 131, 131, 131),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  data["Image"],
                                ),
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(data["Name"],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(data["Position"],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(data["Company"],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 5.0,
                        ),
                      ]),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
