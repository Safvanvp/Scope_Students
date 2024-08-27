import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:scopeindia_student/home.dart';

class CallbackRequest extends StatefulWidget {
  const CallbackRequest({super.key});

  @override
  State<CallbackRequest> createState() => _CallbackRequestState();
}

class _CallbackRequestState extends State<CallbackRequest> {
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final subjectController = TextEditingController();
  final dateController = TextEditingController();
  final phoneController = TextEditingController();
  Country selectedCountry = Country(
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

  Future<void> getDate() async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(currentDate.year - 50),
      lastDate: currentDate,
      initialDate: currentDate,
    );
    if (selectedDate != null) {
      dateController.text = formatDate(selectedDate);
    }
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }

  String? genderValue;
  String? course;

  final _formKey = GlobalKey<FormState>();

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
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Text(
                      "Please fill the following form...!",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                    buildTextField(
                        "Name:", nameController, "Name", Icons.person),
                    SizedBox(height: 30),
                    buildTextField("Mail:", mailController, "Mail", Icons.mail),
                    SizedBox(height: 30),
                    buildPhoneNumberField(),
                    SizedBox(height: 30),
                    buildCourseDropdown(),
                    SizedBox(height: 30),
                    buildDatePicker(),
                    SizedBox(height: 30),
                    buildGenderRadioButtons(),
                    SizedBox(height: 50),
                    buildSubmitButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      String hintText, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon: Icon(icon),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $hintText';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget buildPhoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            "Phone:",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            cursorColor: Colors.black,
            controller: phoneController,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "Enter phone number",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Container(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      countryListTheme: CountryListThemeData(
                        bottomSheetHeight: 550,
                      ),
                      onSelect: (value) {
                        setState(() {
                          selectedCountry = value;
                        });
                      },
                    );
                  },
                  child: Text(
                    "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
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
                        color: Colors.greenAccent[400],
                      ),
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 20,
                      ),
                    )
                  : null,
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 10) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget buildCourseDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            "Course:",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            padding: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButton<String>(
              value: course,
              iconEnabledColor: Colors.grey[800],
              iconSize: 34,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              hint: Text(
                "Course",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              icon: Icon(Icons.arrow_drop_down_outlined),
              underline: Container(
                height: 0,
                color: Colors.black,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  course = newValue;
                });
              },
              items: <String>[
                "Software Programming Courses",
                "Software Testing Courses",
                "Networking, Server, & Cloud",
                "Other Courses",
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            "Date of birth:",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            controller: dateController,
            onTap: () {
              getDate();
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "Choose Date",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon: Icon(Icons.calendar_month_sharp),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a date';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget buildGenderRadioButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            "Gender:",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                RadioMenuButton(
                  value: "Male",
                  groupValue: genderValue,
                  onChanged: (String? value) {
                    setState(() {
                      genderValue = value;
                    });
                  },
                  child: Text("Male"),
                ),
                RadioMenuButton(
                  value: "Female",
                  groupValue: genderValue,
                  onChanged: (String? value) {
                    setState(() {
                      genderValue = value;
                    });
                  },
                  child: Text("Female"),
                ),
                RadioMenuButton(
                  value: "Others",
                  groupValue: genderValue,
                  onChanged: (String? value) {
                    setState(() {
                      genderValue = value;
                    });
                  },
                  child: Text("Others"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSubmitButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        if (_formKey.currentState!.validate()) {
          try {
            FirebaseFirestore.instance.collection("EnquiryRequest").add({
              "Name": nameController.text,
              "Mail": mailController.text,
              "Phone": phoneController.text,
              "Course": course.toString(),
              "DateOfBirth": dateController.text,
              "Gender": genderValue,
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Request sent successfully"),
              ),
            );
          } catch (error) {
            print(error);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to send request")),
            );
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xfffbba02),
          borderRadius: BorderRadius.circular(15),
        ),
        width: MediaQuery.of(context).size.width / 1.5,
        child: Text(
          "Send request",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: Color(0xff071e67),
          ),
        ),
      ),
    );
  }
}
