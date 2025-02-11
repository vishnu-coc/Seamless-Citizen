import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/button.dart';
import 'package:flutter_application_3/login/login.dart';
import 'package:flutter_application_3/textfield.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  Future<void> signUp(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://seamless-backend-382y.onrender.com/api/user/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("Account created successfully: $data");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account created successfully")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } else {
        print("Failed to sign up: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to sign up. Try again.")),
        );
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred. Please try again.")),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
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
                      textEditingController: nameController,
                      hintText: "Enter your name",
                      icon: Icons.person,
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
                        if (nameController.text.isEmpty ||
                            emailController.text.isEmpty ||
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
                        await signUp(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                        setState(() {
                          isLoading = false;
                        });
                      },
                      text: "Sign Up",
                    ),
                    SizedBox(
                      height: height / 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          },
                          child: const Text(
                            " Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
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
