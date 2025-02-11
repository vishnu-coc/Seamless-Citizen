import 'package:flutter/material.dart';
import 'package:flutter_application_3/button.dart';
import 'package:flutter_application_3/login/login.dart';
import 'package:flutter_application_3/login/signup.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Image.asset("assets/d.png", height: 200),
            SizedBox(height: 20),
            Text(
              "Stay connected, stay secure.",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "At Seamless Citizen, we prioritize user security and privacy, ensuring a safe platform for engaging with communities and government services while protecting sensitive information.",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Mybutton(
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              text: "Login",
            ),
            SizedBox(height: 10),
            Mybutton(
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUp()));
              },
              text: "Sign Up",
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ],
        ),
      ),
    );
  }
}
