import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scopeindia_student/home.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

final fireauth = FirebaseAuth.instance;

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Check your email & verify the link..."),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  await fireauth.currentUser!.reload();
                  if (fireauth.currentUser!.emailVerified) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  } else {
                    AlertDialog(
                      title: Text("Email not verified..."),
                    );
                  }
                } catch (error) {
                  print("$error");
                }
              },
              child: Text(
                "Verified",
                style: TextStyle(fontSize: 20),
              ))
        ],
      )),
    );
  }
}
