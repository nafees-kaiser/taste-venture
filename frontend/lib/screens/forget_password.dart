import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_regex/flutter_regex.dart';
import 'package:frontend/screens/otp_page.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';

class ForgetPassword extends StatefulWidget {
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  // const ForgetPassword({super.key});
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Find Your Account',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
                'Enter your email address and we will send you an OTP to reset your password.'),
            SizedBox(height: 30),
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
            // const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                  child: SizedBox(
                    height: 42,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        String email = _inputController.text;
                        if (email.isNotEmpty && email.isEmail()) {
                          ApiSettings api =
                              ApiSettings(endPoint: 'users/verify-email');
                          try {
                            final response = await api
                                .postMethod(json.encode({"email": email}));
                            if (response.statusCode == 200) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpPage.setEmail(
                                    email: email,
                                    nextPath: '/reset-pass',
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(response.body)),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                          // Navigator.pushNamed(context, '/otp-page');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Please enter the Email address')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                      ),
                      child: const Text(
                        "Send",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}
