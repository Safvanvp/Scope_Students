import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scopeindia_student/pages/course.dart';
import 'package:scopeindia_student/widgets/drawer.dart';
import 'package:scopeindia_student/widgets/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_controller.dart' as carousel_slider;
import 'package:flutter/src/material/carousel.dart' as material_carousel;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int currentIndex = 0;

class _HomePageState extends State<HomePage> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName');
      print("hello")
      // userPassword = prefs.getString('userPassword');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Menubar(),
      backgroundColor: Color(0xff071e67),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: GestureDetector(
              onTap: _showImageDialog,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.asset(
                    "Image/unnamed.jpg",
                  )),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color(0xff071e67),
            automaticallyImplyLeading: false,
            expandedHeight: 100,
            centerTitle: true,
            title: Hero(
              tag: "logo",
              child: Image.asset(
                "Image/scope-india-logo-bird.png",
                scale: 1.5,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Stack(
                    children: [
                      Image.asset(
                        "Image/slider_bg.jpg",
                        width: MediaQuery.of(context).size.width,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 45.0),
                        child: Image.asset("Image/scope-india-logo-web.png"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  // height: 300,
                  child: _buildCoursesList(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                // Center(
                //   child: DotsIndicator(
                //     dotsCount: items.length,
                //     position: currentIndex,
                //     decorator: DotsDecorator(
                //       activeColor: Colors.white,
                //       // size: const Size.square(9.0),
                //       // activeSize: const Size(18.0, 9.0),
                //       activeShape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(5.0)),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "Image/5star.png",
                  height: 100,
                ),
                Text(
                  "SCOPE INDIA, your career partner!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "One of the best Training Destination for Software, Networking and Cloud Computing courses in India with 17 years of Industrial experience.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "Software, Networking, and Cloud Professional Education Centre in Kerala from Suffix E Solutions with WORKING PROFESSIONALS oriented on-the-job TRAINING model. SCOPE INDIA provides courses for Software Programming in Python (Data Science | Artificial Intelligence | Machine Learning | Deep Learning, Data Analytics), Java, PHP, .Net, Software Testing Manual and Automation, Cloud Computing (AWS | Azure), Server Administration (MCSE | RHCE), Networking (CCNA), Mobile App Development in Flutter, and Digital Marketing. Training with 100% Trusted Job Based Internship Model. SCOPE INDIA has a Strong Placement Cell that provides jobs to thousands of students every year. We assure you, you won't regret it after training from SCOPE INDIA!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: Column(
                      children: [
                        Image.asset("Image/snowpark-home-icon1.png"),
                        Text(
                          "Training",
                          style: AppWidget.whitesemiboldTextFieldstyle(),
                        ),
                        Text(
                          "You are trained under\nSuffix E Solutions working\nprofessionals,on-the-job\ntraining model.",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
                    Container(
                        child: Column(
                      children: [
                        Image.asset("Image/snowpark-home-icon2.png"),
                        Text(
                          "Internship",
                          style: AppWidget.whitesemiboldTextFieldstyle(),
                        ),
                        Text(
                          "After course completion, you will\nbe proceeded to live projects\nwith a 6 months experience\ncertificate.",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: Column(
                      children: [
                        Image.asset("Image/snowpark-home-icon3.png"),
                        Text(
                          "Grooming",
                          style: AppWidget.whitesemiboldTextFieldstyle(),
                        ),
                        Text(
                          "You are trained under\nSuffix E Solutions working\nprofessionals,on-the-job\ntraining model.",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
                    Container(
                        child: Column(
                      children: [
                        Image.asset("Image/snowpark-home-icon4.png"),
                        Text(
                          "Placement",
                          style: AppWidget.whitesemiboldTextFieldstyle(),
                        ),
                        Text(
                          "After course completion, you will\nbe proceeded to live projects\nwith a 6 months experience\ncertificate.",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
                  ],
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  void _showImageDialog() {
    userName != null
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.all(0),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(190),
                      child: Image.asset(
                        "Image/unnamed.jpg",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        userName!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        : showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.all(0),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(190),
                      child: Image.asset(
                        "Image/unnamed.jpg",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "NO USER",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }

  Widget _buildCoursesList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("CourseBanner").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No courses available.",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return CarouselSlider.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index, realIndex) {
            var course =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
            var courseImage = course['Image'] ?? '';

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Course()),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("You have to register first")),
                );
              },
              child: Container(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(courseImage),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 250,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 2),
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            aspectRatio: 16 / 9,
            initialPage: 0,
          ),
        );
      },
    );
  }
}
