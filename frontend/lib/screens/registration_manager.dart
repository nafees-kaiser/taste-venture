// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_input_field.dart';

class RegistrationVenueManager extends StatefulWidget {
  @override
  _RegistrationVenueManagerState createState() =>
      _RegistrationVenueManagerState();
}

class _RegistrationVenueManagerState extends State<RegistrationVenueManager> {
  String selectedVenueType = 'Restaurant';

  // Track field completion
  final Map<String, bool> fieldStatus = {
    'Venue Name': false,
    'Manager Name': false,
    'Contact': false,
    'Email address': false,
    'Opening time': false,
    'Closing time': false,
    'Description': false,
    'Address': false,
    'Password': false,
    'Re-type Password': false,
  };

  void checkAllFieldsFilled() {
    setState(() {
      fieldStatus['Venue Name'] = _venueNameController.text.isNotEmpty;
      fieldStatus['Manager Name'] = _managerNameController.text.isNotEmpty;
      fieldStatus['Contact'] = _contactController.text.isNotEmpty;
      fieldStatus['Email address'] = _emailAddressController.text.isNotEmpty;
      fieldStatus['Opening time'] = _openingTimeController.text.isNotEmpty;
      fieldStatus['Closing time'] = _closingTimeController.text.isNotEmpty;
      fieldStatus['Description'] = _descriptionController.text.isNotEmpty;
      fieldStatus['Address'] = _addressController.text.isNotEmpty;
      fieldStatus['Password'] = _passwordController.text.isNotEmpty;
      fieldStatus['Re-type Password'] =
          _reTypePasswordController.text.isNotEmpty;
    });
  }

  final TextEditingController _venueNameController = TextEditingController();
  final TextEditingController _managerNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _openingTimeController = TextEditingController();
  final TextEditingController _closingTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reTypePasswordController =
      TextEditingController();

  @override
  void dispose() {
    _venueNameController.dispose();
    _managerNameController.dispose();
    _contactController.dispose();
    _emailAddressController.dispose();
    _openingTimeController.dispose();
    _closingTimeController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _reTypePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool allFieldsFilled = fieldStatus.values.every((filled) => filled);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Add Your Venue',
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        height: 1.2,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Venue type',
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          height: 2.6,
                          color: Color(0xFF020D07),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0x33000000)),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: DropdownButton<String>(
                          value: selectedVenueType,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          isExpanded: true,
                          style: GoogleFonts.getFont(
                            'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            height: 1.5,
                            letterSpacing: 0.4,
                            color: Color(0xFF313144),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedVenueType = newValue!;
                            });
                          },
                          items: <String>['Restaurant', 'Tour Spot']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      CustomInputField(
                        label: 'Venue Name',
                        hintText: 'Enter your venue name',
                        onChanged: (_) => checkAllFieldsFilled(),
                        controller: _venueNameController,
                      ),
                      CustomInputField(
                        label: 'Manager Name',
                        hintText: 'Enter manager’s full name',
                        onChanged: (_) => checkAllFieldsFilled(),
                        controller: _managerNameController,
                      ),
                      CustomInputField(
                        label: 'Contact',
                        hintText: 'eg 017XXXXXXXX',
                        onChanged: (_) => checkAllFieldsFilled(),
                        controller: _contactController,
                      ),
                      CustomInputField(
                        label: 'Email address',
                        hintText: 'eg email@gmail.com',
                        onChanged: (_) => checkAllFieldsFilled(),
                        controller: _emailAddressController,
                      ),
                      SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomInputField(
                              label: 'Opening time',
                              hintText: 'eg hh:mm:ss AM',
                              onChanged: (_) => checkAllFieldsFilled(),
                              controller: _openingTimeController,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: CustomInputField(
                              label: 'Closing time',
                              hintText: 'eg hh:mm:ss PM',
                              onChanged: (_) => checkAllFieldsFilled(),
                              controller: _closingTimeController,
                            ),
                          ),
                        ],
                      ),
                      CustomInputField(
                        label: 'Description',
                        hintText: 'Enter a short description of your venue',
                        height: 180.0,
                        keyboardType: TextInputType.multiline,
                        onChanged: (_) => checkAllFieldsFilled(),
                        controller: _descriptionController,
                      ),
                      CustomInputField(
                        label: 'Address',
                        hintText: 'eg House#1, Road#3, Uttara, Dhaka',
                        onChanged: (_) => checkAllFieldsFilled(),
                        controller: _addressController,
                      ),
                      CustomInputField(
                        label: 'Password',
                        hintText: 'Enter Password',
                        obscureText: true,
                        onChanged: (_) => checkAllFieldsFilled(),
                        controller: _passwordController,
                      ),
                      CustomInputField(
                        label: 'Re-type Password',
                        hintText: 'Re-type your Password',
                        obscureText: true,
                        onChanged: (_) => checkAllFieldsFilled(),
                        controller: _reTypePasswordController,
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: allFieldsFilled
                                ? Color(0xFFFFA500)
                                : Color(0xFF959595),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextButton(
                            onPressed: allFieldsFilled ? () {
                              
                            } : null,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 18),
                              child: Text(
                                'Register',
                                style: GoogleFonts.getFont(
                                  'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
