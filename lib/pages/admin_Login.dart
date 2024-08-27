import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scopeindia_student/pages/Admin_panal.dart';

class AdmineLogin extends StatefulWidget {
  const AdmineLogin({super.key});

  @override
  State<AdmineLogin> createState() => _AdmineLoginState();
}

class _AdmineLoginState extends State<AdmineLogin> {
  TextEditingController UserNameController = new TextEditingController();
  TextEditingController UserPasswordController = new TextEditingController();

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
                child: Column(
                  children: [
                    Text(
                      "Welcome...",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: UserNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: "Enter your Username...",
                          label: Text("UserName"),
                          prefixIcon: Icon(Icons.person)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: UserPasswordController,
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
                      onTap: () {
                        loginAdmin();
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
          ],
        ),
      ),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()["username"] != UserNameController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Your id is incorrect",
            style: TextStyle(fontSize: 20.0),
          )));
        } else if (result.data()["password"] !=
            UserPasswordController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Your password is incorrect",
            style: TextStyle(fontSize: 20.0),
          )));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminHome(
                        username: UserNameController.text,
                      )));
        }
      });
    });
  }
}
