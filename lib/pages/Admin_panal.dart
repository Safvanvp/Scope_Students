import 'package:flutter/material.dart';
import 'package:scopeindia_student/pages/Add_placement.dart';
import 'package:scopeindia_student/pages/Edit_Banner.dart';
import 'package:scopeindia_student/pages/Enquaries.dart';
import 'package:scopeindia_student/pages/Students.dart';
import 'package:scopeindia_student/pages/registration.dart';

class AdminHome extends StatefulWidget {
  final String username;
  const AdminHome({super.key, required this.username});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff071e67),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color(0xff071e67),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Hi ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.username}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "..!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Enquarys()));
                      },
                      child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  colors: [Colors.pink, Colors.orange])),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Enquary's",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddPlacement()));
                      },
                      child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  colors: [Colors.pink, Colors.orange])),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Add Placement",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => AddCourse()));
                    //   },
                    //   child: Container(
                    //       margin: EdgeInsets.only(bottom: 15),
                    //       padding:
                    //           EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(15),
                    //           gradient: LinearGradient(
                    //               colors: [Colors.pink, Colors.orange])),
                    //       width: MediaQuery.of(context).size.width,
                    //       child: Text(
                    //         "Add Courses",
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 20,
                    //             fontWeight: FontWeight.bold),
                    //       )),
                    // ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentsList()));
                      },
                      child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  colors: [Colors.pink, Colors.orange])),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Students",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BannerEdit()));
                      },
                      child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  colors: [Colors.pink, Colors.orange])),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Edit Banners",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registration()));
                      },
                      child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  colors: [Colors.pink, Colors.orange])),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Add Students",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
