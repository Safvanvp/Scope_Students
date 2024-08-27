import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scopeindia_student/pages/verification_page.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

String? gendervalue;
final datecontroller = TextEditingController();
final passwordcontroller = TextEditingController();
final mailcontroller = TextEditingController();
final phoneController = TextEditingController();
final firstnameController = TextEditingController();

Country SelectedCountry = Country(
  phoneCode: "91",
  countryCode: "IN",
  e164Sc: 0,
  geographic: true,
  level: 1,
  name: "India",
  example: "India",
  displayName: "India",
  displayNameNoCountryCode: "IN",
  e164Key: "",
);

class _RegistrationState extends State<Registration> {
  Future<void> getdate() async {
    final DateTime currentdate = DateTime.now();
    final DateTime? selecteddate = await showDatePicker(
        context: context,
        firstDate: DateTime(currentdate.year - 50),
        lastDate: currentdate,
        initialDate: currentdate);
    if (selecteddate != null) {
      datecontroller.text = formatdate(selecteddate);
    }
  }

  String formatdate(DateTime date) {
    return "${date.day.toString().padLeft(2, "0")}-${date.month.toString().padLeft(2, "0")}-${date.year}";
  }

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff071e67),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color(0xff071e67),
            title: Image.asset(
              "Image/scope-india-logo-bird.png",
              scale: 1.5,
            ),
          ),
          SliverToBoxAdapter(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: Image.asset(
                      "Image/unnamed.jpg",
                      height: 120,
                      width: 120,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "REGISTER..!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: firstnameController,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "First Name",
                          labelText: "First Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text("Gender"),
                            ],
                          ),
                          Row(
                            children: [
                              RadioMenuButton(
                                  value: "Male",
                                  groupValue: gendervalue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      gendervalue = value;
                                    });
                                  },
                                  child: Text(
                                    "Male",
                                    style: TextStyle(
                                        // color: Colors.white,
                                        ),
                                  )),
                              RadioMenuButton(
                                value: "Female",
                                groupValue: gendervalue,
                                onChanged: (String? value) {
                                  setState(() {
                                    gendervalue = value;
                                  });
                                },
                                child: Text(
                                  "Female",
                                  // style: TextStyle(color: Colors.white),
                                ),
                              ),
                              RadioMenuButton(
                                value: "Other",
                                groupValue: gendervalue,
                                onChanged: (String? value) {
                                  setState(() {
                                    gendervalue = value;
                                  });
                                },
                                child: Text(
                                  "Others",
                                  // style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: datecontroller,
                      onTap: () {
                        getdate();
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Choose Date",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: Icon(Icons.calendar_month_sharp)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your date of birth';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: mailcontroller,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Mail",
                          labelText: "Mail",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: Icon(Icons.mail)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Password",
                          labelText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: Icon(Icons.key)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      controller: phoneController,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        setState(() {
                          phoneController.text = value;
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter phone number",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black12)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black12)),
                        prefixIcon: Container(
                          padding: EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                countryListTheme: CountryListThemeData(
                                    bottomSheetHeight: 550),
                                onSelect: (value) {
                                  setState(() {
                                    SelectedCountry = value;
                                  });
                                },
                              );
                            },
                            child: Text(
                              "${SelectedCountry.flagEmoji} + ${SelectedCountry.phoneCode}",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        suffixIcon: phoneController.text.length > 9
                            ? Container(
                                margin: EdgeInsets.all(10),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.greenAccent[400]),
                                child: Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              )
                            : null,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (value.length < 10) {
                          return 'Phone number must be at least 10 digits long';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formkey.currentState!.validate()) {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                            email: mailcontroller.text,
                            password: passwordcontroller.text,
                          );
                          User? user = userCredential.user;
                          await userCredential.user!.sendEmailVerification();
                          FirebaseFirestore.instance
                              .collection("Students")
                              .doc(user?.uid)
                              .set({
                            "Name": firstnameController.text,
                            "Gmail": mailcontroller.text,
                            "Dob": datecontroller.text,
                            "Phone":
                                "${SelectedCountry.phoneCode}${phoneController.text}",
                            "Gender": gendervalue,
                            "Password": passwordcontroller.text
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green[400],
                              content: Row(
                                children: [
                                  Text("Registered successfully"),
                                  Icon(Icons.check_circle)
                                ],
                              )));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerificationPage()));
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Row(
                                children: [
                                  Text("$error"),
                                  Icon(Icons.dnd_forwardslash_rounded)
                                ],
                              )));
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.amber[700],
                          borderRadius: BorderRadius.circular(15)),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
