import 'package:flutter/material.dart';
import 'package:scopeindia_student/home.dart';
import 'package:scopeindia_student/widgets/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userEmail;
  String? userName; // Variable to store the user's name
  String? DOB; // Variable to store the user's name
  bool? logcheck;
  var _logout;

  Future<bool> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await prefs.setBool("loged", false);
      _logout = true;
      return _logout;
    } catch (e) {
      print("Error during logout: $e");
      return _logout;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('userEmail');
      userName = prefs.getString('userName'); // Load the user's name
      DOB = prefs.getString('DOB'); // Load the user's name
      logcheck = prefs.getBool('loged');
    });
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () async {
        var res = await logout();
        if (res) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Successfully logged out")));
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (c) => HomePage()), (route) => false);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Couldn't log out!")));
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure you want to log out?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff071e67),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: CircleAvatar(
                radius: 60,
                foregroundImage: AssetImage("Image/unnamed.jpg"),
              )),
              SizedBox(
                height: 30,
              ),
              Text('Name: $userName', // Display the user's name
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                  'DOB: $DOB', // You can replace this with actual DOB if available
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('Email: $userEmail',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 200,
        height: 50,
        child: FloatingActionButton(
          backgroundColor: Color(0xfffbba02),
          onPressed: () => showAlertDialog(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Logout",
                style: AppWidget.whitesemiboldTextFieldstyle(),
              ),
              Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 40,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
