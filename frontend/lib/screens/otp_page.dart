import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/screens/reset_password.dart';
import 'package:frontend/utils/api_settings.dart';

class OtpPage extends StatefulWidget {
  String? email;
  String nextPath = '/reset-pass';
  OtpPage({super.key});
  OtpPage.setEmail({super.key, this.email, this.nextPath = '/reset-pass'});
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OtpPage> {
  ApiSettings api = ApiSettings(endPoint: 'users/verify-otp');
  final TextEditingController _otpController = TextEditingController();

  Future<(String, int)> verifyOtp() async {
    final data = {'email': widget.email!, 'otp': _otpController.text};
    try {
      final response = await api.postMethod(json.encode(data));
      return (response.body, response.statusCode);
    } catch (e) {
      return (e.toString(), 404);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter OTP',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Please enter the OTP sent to your email address',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 30.0),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(
                // border: OutlineInputBorder(),
                hintText: 'OTP',
              ),
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            SizedBox(height: 30.0),
            SizedBox(
              height: 42,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String otp = _otpController.text;
                  if (otp.isNotEmpty) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('OTP is verified')),
                    // );
                    final (body, status) = await verifyOtp();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(body)),
                    );
                    if (status == 200) {
                      if (widget.nextPath == '/reset-pass') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPassword(
                              email: widget.email!,
                            ),
                          ),
                        );
                      } else {
                        Navigator.pushNamed(context, widget.nextPath);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(body)),
                      );
                    }

                    // Navigator.pushNamed(context, '/reset-pass');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter the OTP')),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
