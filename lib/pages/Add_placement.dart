import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddPlacement extends StatefulWidget {
  const AddPlacement({super.key});

  @override
  State<AddPlacement> createState() => _AddPlacementState();
}

class _AddPlacementState extends State<AddPlacement> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController PositionController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();

  Future<void> getImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadPlacement() async {
    if (selectedImage != null && nameController.text.isNotEmpty) {
      try {
        String addId = randomAlphaNumeric(10);
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child("StudentImage").child(addId);
        UploadTask uploadTask = firebaseStorageRef.putFile(selectedImage!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        Map<String, dynamic> placed = {
          "Name": nameController.text,
          "Image": downloadUrl,
          "Company": companyNameController.text,
          "Position": PositionController.text
        };

        await FirebaseFirestore.instance
            .collection("placements")
            .doc(addId)
            .set(placed);

        setState(() {
          selectedImage = null;
          nameController.clear();
          companyNameController.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Placement has been uploaded successfully...",
            style: TextStyle(fontSize: 20.0),
          ),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Error: $e",
            style: TextStyle(fontSize: 20.0),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff071e67),
      appBar: AppBar(
        title: Text(
          "Add Placement",
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: getImage,
                child: Center(
                  child: Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(56, 255, 255, 255),
                      border: Border.all(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: selectedImage == null
                        ? Icon(
                            Icons.camera_alt_outlined,
                            size: 30,
                            color: Colors.white,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Add Image",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 30),
              _buildTextField(nameController, "Name"),
              SizedBox(height: 30),
              _buildTextField(companyNameController, "Company"),
              SizedBox(height: 30),
              _buildTextField(PositionController, "Position"),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: ElevatedButton(
                    onPressed: uploadPlacement,
                    child: Text(
                      "Add Placement",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(0xffececf8), borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
