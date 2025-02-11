import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/button.dart';
import 'package:flutter_application_3/login/signup.dart';
import 'package:flutter_application_3/textfield.dart';
import 'package:flutter_application_3/home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> login(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      http.Response response = await http.post(
        Uri.parse("https://seamless-backend-382y.onrender.com/api/user/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String token = data['token'];

        await prefs.setString('user_token', token);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "Login failed with status: ${response.statusCode}. Check your credentials.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: ${e.toString()}")),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: height / 2.7,
                      child: Image.asset('assets/c.png'),
                    ),
                    TextfieldInput(
                      textEditingController: emailController,
                      hintText: "Enter your email",
                      icon: Icons.email,
                    ),
                    TextfieldInput(
                      textEditingController: passwordController,
                      hintText: "Enter your password",
                      ispass: true,
                      icon: Icons.lock,
                    ),
                    Mybutton(
                      ontap: () async {
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("All fields are required")),
                          );
                          return;
                        }
                        setState(() {
                          isLoading = true;
                        });
                        await login(emailController.text.trim(),
                            passwordController.text.trim());
                        setState(() {
                          isLoading = false;
                        });
                      },
                      text: "Login",
                    ),
                    SizedBox(height: height / 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?",
                            style: TextStyle(fontSize: 16)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()),
                            );
                          },
                          child: const Text(" Sign Up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
