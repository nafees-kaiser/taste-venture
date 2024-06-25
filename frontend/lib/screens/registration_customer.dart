import 'package:flutter/material.dart';
import 'package:frontend/widgets/registration_form_customer.dart';
import 'package:frontend/widgets/textbox.dart';

class RegistrationCustomer extends StatelessWidget {
  const RegistrationCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: const RegistrationFormCustomer(),
        ),
      ),
    );
  }
}
