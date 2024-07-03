import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constant.dart';
import '../widgets/custom_input_field.dart';

class AddTourspotAdditionalInfo extends StatefulWidget {
  @override
  State<AddTourspotAdditionalInfo> createState() =>
      _AddTourspotAdditionalInfoState();
}

class _AddTourspotAdditionalInfoState extends State<AddTourspotAdditionalInfo> {
  // const AddTourspotAdditionalInfo({super.key});
  String selectedType1 = 'Yes';
  String selectedType2 = 'Yes';
  String selectedType3 = 'Yes';
  String selectedType4 = 'Yes';

  final Map<String, bool> fieldStatus = {
    'Fee': false,
    'Services': false,
  };

  void checkAllFieldsFilled() {
    setState(() {
      fieldStatus['Fee'] = _feeController.text.isNotEmpty;
      fieldStatus['Services'] = _serviceController.text.isNotEmpty;
    });
  }

  final TextEditingController _feeController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();

  @override
  void dispose() {
    _feeController.dispose();
    _serviceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool allFieldsFilled = fieldStatus.values.every((filled) => filled);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Additional Information"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      CustomInputField(
                        label: 'Entry Fee',
                        hintText: 'Enter the value of your entry fee',
                        onChanged: (_) => checkAllFieldsFilled(),
                        controller: _feeController,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'WiFi Facility',
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          height: 2.6,
                          color: Color(0xFF020D07),
                        ),
                      ),
                      // SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0x33000000)),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: DropdownButton<String>(
                          value: selectedType1,
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
                              selectedType1 = newValue!;
                            });
                          },
                          items: <String>['Yes', 'No']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Parking & Transport',
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          height: 2.6,
                          color: Color(0xFF020D07),
                        ),
                      ),
                      // SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0x33000000)),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: DropdownButton<String>(
                          value: selectedType2,
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
                              selectedType2 = newValue!;
                            });
                          },
                          items: <String>['Yes', 'No']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Food & Drinks',
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          height: 2.6,
                          color: Color(0xFF020D07),
                        ),
                      ),
                      // SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0x33000000)),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: DropdownButton<String>(
                          value: selectedType3,
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
                              selectedType3 = newValue!;
                            });
                          },
                          items: <String>['Yes', 'No']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Indoor Pool',
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          height: 2.6,
                          color: Color(0xFF020D07),
                        ),
                      ),
                      // SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0x33000000)),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: DropdownButton<String>(
                          value: selectedType4,
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
                              selectedType4 = newValue!;
                            });
                          },
                          items: <String>['Yes', 'No']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      CustomInputField(
                        label: 'Other Services',
                        hintText: 'What else does your venue offer?',
                        height: 180.0,
                        keyboardType: TextInputType.multiline,
                        onChanged: (_) => checkAllFieldsFilled(),
                        controller: _serviceController,
                      ),
                      SizedBox(height: 25),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: allFieldsFilled
                                ? SECONDARY_COLOR
                                : Color(0xFF959595),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextButton(
                            onPressed: allFieldsFilled
                                ? () {
                                    Navigator.pushNamed(context, '/login');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Registration Successfully Done')),
                                    );
                                  }
                                : null,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 18),
                              child: Text(
                                'Submit',
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