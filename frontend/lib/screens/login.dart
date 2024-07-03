import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/utils/constant.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // variables
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email = "", password = "";
  String demoEmail = "rafsanprove@gmail.com", demoPassword = "password123";
  String alert = "";
  bool isButtonEnabled = false;

  // methods
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

  void check() {
    print("Login Button Pressed");
    setState(() {
      email = emailController.text;
      password = passwordController.text;
    });

    print("Email: $email");
    print("Password: $password");

    if (email == "" || password == "") {
      setState(() {
        alert = "Warning: Please enter email and password";
      });
    } else {
      if (email == demoEmail && password == demoPassword) {
        /*
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Successful'),
              content: Text('You have logged in successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        */

        Fluttertoast.showToast(
            msg: "Login Successful",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.pushNamed(context, '/customer-homepage');
      } else {
        setState(() {
          alert = "Warning: Invalid email or password";
        });
      }
    }
  }

  bool isEmpty() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return true;
    } else {
      return false;
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
                  const Text("Email address",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),

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
                              color: Color.fromRGBO(149, 149, 149, 1))),
                    ),
                  ),

                  // Password
                  const Text("Password",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

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
                              color: Color.fromRGBO(149, 149, 149, 1))),
                    ),
                  ),

                  // Incorrect credential alert
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(alert,
                          style:
                              const TextStyle(fontSize: 14, color: INCORRECT)),
                    ),
                  ),

                  // Login button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 20.0),
                    child: SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: check,
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
                      // print("Forgot Password? tapped");
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
                      // print("Don't have an account? tapped");
                      Navigator.pushNamed(context, '/registration/customer');
                    },
                  ),

                  // Want to add your restaurant or tourist spot?
                  GestureDetector(
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                        child: Text(
                          "Want to add your restaurant?",
                          style: TextStyle(
                            color: TEXT,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/add-restaurant');
                      print(
                          "Want to add your restaurant or tourist spot? tapped");
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
