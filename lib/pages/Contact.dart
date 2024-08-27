import 'package:flutter/material.dart';
import 'package:scopeindia_student/pages/callback_requast.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width / 1.3,
        height: 50,

        // margin: EdgeInsets.only(left: 50, right: 50),
        child: FloatingActionButton(
          onPressed: () {
            // print('Floating Action Button Pressed'),
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CallbackRequest()));
          },

          child: Text(
            "GET A CALLBACK",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Color(0xff071e67)),
          ),
          tooltip: 'Increment',
          // shape: ,
          backgroundColor: Color(0xfffbba02),
          // foregroundColor: Colors.white,
          elevation: 5.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Color(0xff071e67),
      // endDrawer: Menubar(),
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
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "SCOPE INDIA is open\n365 days a year",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xfffbba02),
                      fontSize: 30,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Let's discuss your career,\n24/7 free Consultation",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  "Image/5star.png",
                  height: 100,
                ),
                Text(
                  "Google 4.9 * Rated Institute",
                  style: TextStyle(
                      color: const Color.fromARGB(218, 255, 255, 255),
                      fontSize: 10),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Location",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Branches(
                  "Technopark TVM, Kerala",
                  "Phase 1, Main Gate, Diamond Arcade,\nNear Technopark, Trivandrum",
                  "9745936073",
                  "technopark@scopeindia.org",
                ),
                SizedBox(
                  height: 30,
                ),
                Branches(
                  "Thampanoor TVM, Kerala",
                  "TC 25/1403/3, Athens Plaza, SS Kovil Road,\nThampanoor, Trivandrum, Kerala 695001",
                  "9745936073",
                  "info@scopeindia.org",
                ),
                SizedBox(
                  height: 30,
                ),
                Branches(
                  "Kochi, Kerala",
                  "SCOPE INDIA, Vasanth Nagar Rd,\nnear JLN Metro Station,\nKaloor, Kochi, Kerala 682025",
                  "7592939481",
                  "kochi@scopeindia.org",
                ),
                SizedBox(
                  height: 30,
                ),
                Branches(
                  "Nagercoil, Tamil Nadu",
                  "SCOPE INDIA, Near WCC College,\nPalace Rd, Nagercoil, Tamil Nadu 629001",
                  "8075536185",
                  "ngl@scopeindia.org",
                ),
                SizedBox(
                  height: 30,
                ),
                Branches(
                  "Nagercoil, Tamil Nadu",
                  "SCOPE INDIA, Pharma Street, 5/2 Ward 28,\nDistillery Road, Putheri Nagercoil\n(Near WCC Jn)",
                  "8075536185",
                  "ngl@scopeindia.org",
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container Branches(
    String branch,
    String location,
    String phone,
    String mail,
  ) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
          color: Color.fromARGB(56, 255, 255, 255)),
      child: Column(
        children: [
          Text(
            branch,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 15,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    location,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.phone,
                size: 15,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "+91 $phone",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.mail,
                size: 15,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                mail,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.link,
                size: 15,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "www.scopeindia.org",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.map,
                size: 15,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Location Route Map",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
