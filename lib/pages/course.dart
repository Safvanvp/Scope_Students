import 'package:flutter/material.dart';
import 'package:scopeindia_student/pages/course_catagory.dart';

class Course extends StatefulWidget {
  const Course({super.key});

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff071e67),
      appBar: AppBar(
        title: Text(
          "Departments",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Container(
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseCatagory(
                                branch: "Software Programming Courses")));
                  },
                  child: Catagory(context, "Software Programming Courses")),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseCatagory(
                                branch: "Software Testing Courses")));
                  },
                  child: Catagory(context, "Software Testing Courses")),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseCatagory(
                                branch: "Networking, Server, & Cloud")));
                  },
                  child: Catagory(context, "Networking, Server, & Cloud")),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CourseCatagory(branch: "Other Courses")));
                  },
                  child: Catagory(context, "Other Courses")),
            ],
          ),
        ),
      ),
    );
  }

  Container Catagory(
    BuildContext context,
    String category,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(56, 255, 255, 255),
        border: Border.all(color: Colors.white, width: 2),
      ),
      padding: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      child: Text(
        category,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
