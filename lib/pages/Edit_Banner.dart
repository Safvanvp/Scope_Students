import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:scopeindia_student/widgets/text_styles.dart';

class BannerEdit extends StatefulWidget {
  const BannerEdit({super.key});

  @override
  State<BannerEdit> createState() => _BannerEditState();
}

class _BannerEditState extends State<BannerEdit> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  bool isUploading = false;

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

  Future<void> uploadBanner() async {
    if (selectedImage != null && nameController.text.isNotEmpty) {
      setState(() {
        isUploading = true; // Start the uploading process
      });

      try {
        String addId = randomAlphaNumeric(10);
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child("CourseBanner").child(addId);
        UploadTask uploadTask = firebaseStorageRef.putFile(selectedImage!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        Map<String, dynamic> placed = {
          "Name": nameController.text,
          "Image": downloadUrl,
        };

        await FirebaseFirestore.instance
            .collection("CourseBanner")
            .doc(addId)
            .set(placed);

        setState(() {
          selectedImage = null;
          nameController.clear();
          isUploading = false; // End the uploading process
        });

        Navigator.of(context).pop(); // Close the dialog

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Banner has been uploaded successfully...",
            style: TextStyle(fontSize: 20.0),
          ),
        ));
      } catch (e) {
        setState(() {
          isUploading = false; // End the uploading process
        });

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

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: 50,
        height: 50,
        child: FloatingActionButton(
          backgroundColor: Color(0xfffbba02),
          onPressed: () => _showAlertDialog(context),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      backgroundColor: Color(0xff071e67),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: Text(
          "Banners",
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("CourseBanner")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("$Error");
              } else {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      return Container(
                        padding: EdgeInsets.only(
                            top: 10, right: 10, bottom: 10, left: 10),
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.transparent),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  data["Image"],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Name : " + data["Name"],
                                    style:
                                        AppWidget.whitesemiboldTextFieldstyle(),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      DeleteEnquiry(
                                          snapshot.data!.docs[index].id);
                                    },
                                    child: Center(
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 20),
                                          decoration: BoxDecoration(
                                              color: Color(0xfffe8f33),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Icon(
                                            Icons.delete_outline_outlined,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }

  Future<void> DeleteEnquiry(String id) async {
    await FirebaseFirestore.instance
        .collection("CourseBanner")
        .doc(id)
        .delete();
  }

  _showAlertDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade500,
          title: Text(
            'Add Course_Banner',
            style: TextStyle(color: Colors.white),
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: getImage,
                  child: Center(
                    child: Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
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
                if (isUploading)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: AppWidget.lightTextFieldstyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text(
                'OK',
                style: AppWidget.lightTextFieldstyle(),
              ),
              onPressed: () {
                uploadBanner(); // Upload banner and dismiss the dialog
              },
            ),
          ],
        );
      },
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
