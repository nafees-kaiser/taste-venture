import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
// import 'package:frontend/utils/date_picker.dart';
import 'package:frontend/widgets/textbox.dart';
import 'package:intl/intl.dart';

class RegistrationFormCustomer extends StatefulWidget {
  const RegistrationFormCustomer({super.key});

  @override
  RegistrationFormCustomerState createState() =>
      RegistrationFormCustomerState();
}

class RegistrationFormCustomerState extends State<RegistrationFormCustomer> {
  final _formKey = GlobalKey<FormState>();
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

  // final [fullName, contact, email] = controller;
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((onValue) => setState(() {
          // _dateTime = onValue!;
          controller[3].text = DateFormat('dd/MM/yyyy').format(onValue!);
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
            controller: controller[0],
            decoration: const InputDecoration(
              hintText: 'Enter your full name',
              labelText: 'Full name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your full name";
              }
              return null;
            },
          ),
          Textbox(
            controller: controller[1],
            decoration: const InputDecoration(
              hintText: 'eg 01XXXXXXXXX',
              labelText: 'Contact',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your full name";
              }
              return null;
            },
          ),
          Textbox(
            controller: controller[2],
            decoration: const InputDecoration(
              hintText: 'eg email@email.com',
              labelText: 'Email',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your full name";
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
                  controller: controller[3],
                  decoration: InputDecoration(
                    hintText: "dd/mm/yyyy",
                    labelText: "Date of birth",
                    suffixIcon: IconButton(
                      onPressed: _showDatePicker,
                      icon: Icon(Icons.date_range, color: HINT_TEXT_COLOR),
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
                child: DropdownMenu<String>(
                  controller: controller[4],
                  dropdownMenuEntries: _genderMenuItems,
                  label: const Text('Gender'),
                  expandedInsets: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          Textbox(
            obscureText: !showPassword,
            controller: controller[5],
            decoration: InputDecoration(
                hintText: '*** *** ***',
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: showPassword ? Icon(Icons.visibility, color: HINT_TEXT_COLOR)
                  : Icon(Icons.visibility_off, color: HINT_TEXT_COLOR),
                )),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
          ),
          Textbox(
            obscureText: !showRetypePassword,
            controller: controller[6],
            decoration: InputDecoration(
              hintText: '*** *** ***',
              labelText: 'Retype password',
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showRetypePassword = !showRetypePassword;
                    });
                  },
                  icon: showRetypePassword ? Icon(Icons.visibility, color: HINT_TEXT_COLOR)
                  : Icon(Icons.visibility_off, color: HINT_TEXT_COLOR),
                )),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
          ),
          Textbox(
            controller: controller[7],
            decoration: const InputDecoration(
              hintText: 'eg h#1, r#1, Mirpur, Dhaka',
              labelText: 'Address',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your address";
              }
              return null;
            },
          ),

          DropdownMenu(
            dropdownMenuEntries: _isMarriedMenuItems,
            label: const Text('Marital status'),
            controller: controller[8],
            expandedInsets: EdgeInsets.zero,
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
                Navigator.pushNamed(context, '/login');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isButtonEnabled
                  ? Color.fromRGBO(252, 81, 16, 1)
                  : Color.fromRGBO(149, 149, 149, 1),
              minimumSize: const Size(double.infinity, 0),
            ),
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}
