import 'package:flutter/material.dart';
import 'package:scopeindia_student/home.dart';
import 'package:scopeindia_student/pages/Contact.dart';
import 'package:scopeindia_student/pages/Placement_cell.dart';
import 'package:scopeindia_student/pages/Profile.dart';
import 'package:scopeindia_student/pages/aboutus.dart';
import 'package:scopeindia_student/pages/admin_Login.dart';
import 'package:scopeindia_student/pages/course.dart';
import 'package:scopeindia_student/pages/student_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menubar extends StatefulWidget {
  const Menubar({super.key});

  @override
  State<Menubar> createState() => _MenubarState();
}

class _MenubarState extends State<Menubar> {
  String? email;

  Future<void> myShred() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('userEmail');
    });
  }

  @override
  void initState() {
    super.initState();
    myShred();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xff071e67),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 60.0),
          ListTile(
            leading: Icon(Icons.home_outlined, color: Colors.white),
            title: Text(
              "HOME",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.book_outlined, color: Colors.white),
            title: Text(
              "COURSES",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Course()));
            },
          ),
          ListTile(
            leading: Icon(Icons.people, color: Colors.white),
            title: Text(
              "PLACEMENT CELL",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PlacementCell()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: Colors.white),
            title: Text(
              "KNOW SCOPE INDIA",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AboutUS()));
            },
          ),
          ListTile(
            leading: Icon(Icons.call, color: Colors.white),
            title: Text(
              "CONTACT US",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Contact()));
            },
          ),
          ListTile(
            leading: Icon(Icons.swap_vert_circle_rounded, color: Colors.white),
            title: Text(
              "INSTRUCTOR LOGIN",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AdmineLogin()));
            },
          ),
          SizedBox(height: 300.0), // Adjust height for spacing at the bottom

          // Conditional rendering based on whether the user is logged in or not
          email != null
              ? ListTile(
                  leading: Icon(Icons.person_3_rounded, color: Colors.white),
                  title: Text(
                    "Profile",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                )
              : ListTile(
                  leading: Icon(Icons.person_3_rounded, color: Colors.white),
                  title: Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentLogin()));
                  },
                ),
        ],
      ),
    );
  }
}
