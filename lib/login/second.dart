import 'package:flutter/material.dart';
import 'package:flutter_application_3/login/first.dart';
import 'package:flutter_application_3/login/third.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage("assets/b.png")),
                SizedBox(height: 20),
                Text(
                  "Together, we empower change—seamlessly connecting citizens and communities for a brighter future",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Seamless Citizen is a dynamic platform designed to bridge the gap between the public and government services. We believe that empowered citizens are key to building stronger, more resilient communities",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ThirdPage()));
              },
              child: const Text(
                "Next",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FirstPage()));
              },
              child: const Text(
                "Previous",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
