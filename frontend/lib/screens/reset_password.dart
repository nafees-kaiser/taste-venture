import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // const ResetPassword({super.key});
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Reset Account Password',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Please enter your new password',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0),
            ),
            SizedBox(height: 30.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                // border: OutlineInputBorder(),
                hintText: 'New Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                // border: OutlineInputBorder(),
                hintText: 'Confirm New Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 30.0),
            SizedBox(
              height: 42,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String password = _passwordController.text;
                  String confirmPassword = _confirmPasswordController.text;
                  if (password.isNotEmpty && confirmPassword.isNotEmpty) {
                    if (password == confirmPassword) {
                      Navigator.pushNamed(context, '/login');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Password reset successfully')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Passwords do not match')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields')),
                    );
                  }
                },
                child: Text('Reset Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
