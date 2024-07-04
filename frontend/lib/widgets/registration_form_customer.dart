import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/customer.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/custom_dropdown_menu.dart';
// import 'package:frontend/utils/date_picker.dart';
import 'package:frontend/widgets/textbox.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class RegistrationFormCustomer extends StatefulWidget {
  const RegistrationFormCustomer({super.key});

  @override
  RegistrationFormCustomerState createState() =>
      RegistrationFormCustomerState();
}

class RegistrationFormCustomerState extends State<RegistrationFormCustomer> {
  final _formKey = GlobalKey<FormState>();
  final dateFormat = DateFormat('dd/MM/yyyy');
  final controller = List<TextEditingController>.generate(
      9, (int index) => TextEditingController());
  final List<String> _gender = ['Male', 'Female', 'Others'];
  final List<String> _isMarried = ['Yes', 'No'];

  late final List<DropdownMenuEntry<String>> _genderMenuItems =
      _gender.map((toElement) {
    return DropdownMenuEntry(value: toElement, label: toElement);
  }).toList();

  late final List<DropdownMenuEntry<String>> _isMarriedMenuItems =
      _isMarried.map((toElement) {
    return DropdownMenuEntry(value: toElement, label: toElement);
  }).toList();

  bool isButtonEnabled = false;

  bool showPassword = false;
  bool showRetypePassword = false;

  Future<void> register() async {
    final String fullName = controller[0].text;
    final String contact = controller[1].text;
    final String email = controller[2].text;
    final String dob = controller[3].text;
    final String gender = controller[4].text;
    final String password = controller[5].text;
    final String address = controller[7].text;
    final String married = controller[8].text;

    print('***${dateFormat.parse(dob)}****');

    Customer customer = Customer(
      fullName: fullName,
      contact: contact,
      email: email,
      dob: dob,
      address: address,
      gender: gender,
      married: married,
      password: password,
    );

    final response = await http.post(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(customer.toJson()),
    );

    print(response.statusCode);
  }

  // final [fullName, contact, email] = controller;
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((onValue) => setState(() {
          // _dateTime = onValue!;
          controller[3].text = dateFormat.format(onValue!);
        }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (final i in controller) {
      i.addListener(_enableOrDesableButton);
    }
  }

  @override
  void dispose() {
    for (final i in controller) {
      i.dispose();
    }
    super.dispose();
  }

  void _valuePrint() {
    for (final i in controller) {
      debugPrint('${i.text} ** ');
    }
  }

  void _enableOrDesableButton() {
    for (final i in controller) {
      if (i.text.isEmpty) {
        setState(() {
          isButtonEnabled = false;
        });
        break;
      } else {
        setState(() {
          isButtonEnabled = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final datePicker = DatePicker(
    //   context: context,
    //   initialDate: DateTime.now(),
    //   firstDate: DateTime(1900),
    //   lastDate: DateTime.now(),
    // );
    // final _showDatePicker = datePicker.customShowDatePicker();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Textbox(
            label: 'Full name',
            controller: controller[0],
            decoration: const InputDecoration(
              hintText: 'Enter your full name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your full name";
              }
              return null;
            },
          ),
          Textbox(
            label: 'Contact',
            controller: controller[1],
            decoration: const InputDecoration(
              hintText: 'eg 01XXXXXXXXX',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your contact";
              }
              return null;
            },
          ),
          Textbox(
            label: 'Email',
            controller: controller[2],
            decoration: const InputDecoration(
              hintText: 'eg email@email.com',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email";
              }
              return null;
            },
          ),
          // DateTextbox(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Textbox(
                  label: "Date of birth",
                  controller: controller[3],
                  decoration: InputDecoration(
                    hintText: "dd/mm/yyyy",
                    suffixIcon: IconButton(
                      onPressed: _showDatePicker,
                      icon: Icon(Icons.date_range, color: SECONDARY_BACKGROUND),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your date of birth";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CustomDropdownMenu(
                  controller: controller[4],
                  menuItems: _genderMenuItems,
                  initialValue: _gender[0],
                  label: 'Gender',
                ),
              ),
            ],
          ),
          Textbox(
            label: 'Password',
            obscureText: !showPassword,
            controller: controller[5],
            decoration: InputDecoration(
                hintText: '*** *** ***',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: showPassword
                      ? Icon(Icons.visibility, color: SECONDARY_BACKGROUND)
                      : Icon(Icons.visibility_off, color: SECONDARY_BACKGROUND),
                )),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
          ),
          Textbox(
            label: 'Retype password',
            obscureText: !showRetypePassword,
            controller: controller[6],
            decoration: InputDecoration(
                hintText: '*** *** ***',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showRetypePassword = !showRetypePassword;
                    });
                  },
                  icon: showRetypePassword
                      ? Icon(Icons.visibility, color: SECONDARY_BACKGROUND)
                      : Icon(Icons.visibility_off, color: SECONDARY_BACKGROUND),
                )),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
          ),
          Textbox(
            label: 'Address',
            controller: controller[7],
            decoration: const InputDecoration(
              hintText: 'eg h#1, r#1, Mirpur, Dhaka',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your address";
              }
              return null;
            },
          ),

          CustomDropdownMenu(
            controller: controller[8],
            menuItems: _isMarriedMenuItems,
            initialValue: _isMarried[0],
            label: 'Marital status',
          ),

          // Container(
          //   width: double.infinity,
          //   child: DropdownMenu(
          //     dropdownMenuEntries: _isMarriedMenuItems,
          //     label: const Text('Marital status'),
          //     controller: controller[8],
          //     expandedInsets: EdgeInsets.zero,
          //   ),
          // ),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('Processing Data')),
                // );
                // register();
                Navigator.pushNamed(context, '/preference');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isButtonEnabled ? PRIMARY_COLOR : DISABLE,
              minimumSize: const Size(double.infinity, 0),
            ),
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}
