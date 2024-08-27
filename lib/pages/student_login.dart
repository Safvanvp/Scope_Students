import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scopeindia_student/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({super.key});

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  final passwordcontroller = TextEditingController();
  final mailcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Image/iPhone 14 & 15 Pro Max - 1.png"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 250, left: 20, right: 20),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Text(
                        "Welcome...",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: mailcontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: "Enter your email...",
                            label: Text("Mail"),
                            prefixIcon: Icon(Icons.markunread)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: passwordcontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: "Enter your Password...",
                            label: Text("Password"),
                            prefixIcon: Icon(Icons.key)),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () async {
                          bool isLoggedIn = await loginStudent();
                          if (isLoggedIn) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          width: MediaQuery.of(context).size.width / 3,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            "Log in",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> loginStudent() async {
    bool isValidUser = false;

    // Query Firestore for students with the matching email
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Students")
        .where("Gmail", isEqualTo: mailcontroller.text.trim())
        .get();

    // Check if any documents match the query
    if (snapshot.docs.isNotEmpty) {
      var userDoc = snapshot.docs.first;

      // Validate the password
      if (userDoc["Password"] == passwordcontroller.text.trim()) {
        // Save the login details in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userEmail', mailcontroller.text.trim());
        await prefs.setString('userPassword', passwordcontroller.text.trim());

        // Save the user's name in SharedPreferences
        await prefs.setString('userName', userDoc["Name"]);
        await prefs.setString('DOB', userDoc["Dob"]);

        // await prefs.setString('DOB', userDoc["Dob"]);

        await prefs.setBool("loged", true);

        isValidUser = true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Your password is incorrect",
          style: TextStyle(fontSize: 20.0),
        )));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Your email is incorrect",
        style: TextStyle(fontSize: 20.0),
      )));
    }

    return isValidUser;
  }
}
