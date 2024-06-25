import 'package:flutter/material.dart';
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
  int index = 0;
  final textEditingController = TextEditingController();
  final controller = List<TextEditingController>.generate(
      9, (int index) => TextEditingController());
  final List<String> _gender = ['Male', 'Female', 'Others'];
  final List<String> _isMarried = ['Yes', 'No'];

  late List<DropdownMenuEntry<String>> _genderMenuItems =
      _gender.map((toElement) {
    return DropdownMenuEntry(value: toElement, label: toElement);
  }).toList();

  late List<DropdownMenuEntry<String>> _isMarriedMenuItems =
      _isMarried.map((toElement) {
    return DropdownMenuEntry(value: toElement, label: toElement);
  }).toList();

  // final [fullName, contact, email] = controller;
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2028),
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
      i.addListener(_valuePrint);
    }
    textEditingController.addListener(_textValue);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    for (final i in controller) {
      i.dispose();
    }
    super.dispose();
  }

  void _textValue() {
    final text = textEditingController.text;
    debugPrint(text);
  }

  void _valuePrint() {
    for (final i in controller) {
      debugPrint('${i.text} ** ');
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
            children: [
              Expanded(
                child: Textbox(
                  controller: controller[3],
                  decoration: InputDecoration(
                    hintText: "dd/mm/yyyy",
                    labelText: "Date of birth",
                    suffixIcon: IconButton(
                      onPressed: _showDatePicker,
                      icon: Icon(Icons.date_range),
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
                ),
              ),
            ],
          ),
          Textbox(
            controller: controller[5],
            decoration: const InputDecoration(
              hintText: '*** *** ***',
              labelText: 'Password',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
          ),
          Textbox(
            controller: controller[6],
            decoration: const InputDecoration(
              hintText: '*** *** ***',
              labelText: 'Retype password',
            ),
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
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}
