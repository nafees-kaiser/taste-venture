import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/loggedin.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/utils/api_settings.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Variables
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String alert = "";
  bool isButtonEnabled = false;

  ApiSettings api = ApiSettings(endPoint: 'users/login');

  // Methods
  @override
  void initState() {
    super.initState();
    emailController.addListener(updateButtonState);
    passwordController.addListener(updateButtonState);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled =
          emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  Future<void> check() async {
    String email = emailController.text;
    String password = passwordController.text;
    Loggedin login = Loggedin(
      email: email,
      password: password,
    );

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        alert = "Warning: Please enter email and password";
      });
    } else {
      try {
        final response = await api.postMethod(login.toJson());

        if (response.statusCode == 200) {
          // Login successful
          var jsonResponse = jsonDecode(response.body);
          var user = jsonResponse['user'];
          var token = jsonResponse['tokens']['access'];
          print(token);

          Fluttertoast.showToast(
            msg: "Login Successful",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          Navigator.pushNamed(context, '/customer-homepage');
        } else if (response.statusCode == 400) {
          // Invalid credentials
          setState(() {
            alert = "Warning: Invalid email or password";
          });
        } else if (response.statusCode == 404) {
          // User not found
          setState(() {
            alert = "User Not Found";
          });
        } else {
          // Other errors
          throw Exception('Failed to login: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
        Fluttertoast.showToast(
          msg: "Error occurred. Please try again later.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Email Address
                const Text(
                  "Email address",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Email address text field
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(149, 149, 149, 1),
                        ),
                      ),
                      hintText: "Enter your email address",
                      hintStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(149, 149, 149, 1),
                      ),
                    ),
                  ),
                ),

                // Password
                const Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Password Text Field
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(149, 149, 149, 1),
                        ),
                      ),
                      hintText: "Enter your password",
                      hintStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(149, 149, 149, 1),
                      ),
                    ),
                  ),
                ),

                // Incorrect credential alert
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      alert,
                      style: const TextStyle(fontSize: 14, color: INCORRECT),
                    ),
                  ),
                ),

                // Login button
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 20.0),
                  child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isButtonEnabled ? check : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isButtonEnabled ? PRIMARY_COLOR : DISABLE,
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),

                // Forgot Password?
                GestureDetector(
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: TEXT,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/forget-password');
                  },
                ),

                // Don't have an account?
                GestureDetector(
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: TEXT,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/registration/customer');
                  },
                ),

                  // Want to add your restaurant or tourist spot?
                  GestureDetector(
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                        child: Text(
                          "Want to add your restaurant or tourist spot?",
                          style: TextStyle(
                            color: TEXT,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/add-restaurant');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
