import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/models/booking.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class Booking extends StatefulWidget {
  final String fee;

  Booking({required this.fee});
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  TextEditingController _dateController = TextEditingController();
  int _guestCount = 1;
  late int _fee;

  ApiSettings api = ApiSettings(endPoint: 'users/login');

  @override
  void initState() {
    super.initState();
    _fee = int.parse(widget.fee); // Convert the string fee to int
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _incrementGuest() {
    setState(() {
      _guestCount++;
    });
  }

  void _decrementGuest() {
    setState(() {
      if (_guestCount > 1) {
        _guestCount--;
      }
    });
  }

  Future<void> check() async {
    int number_of_people = _guestCount;
    int subtotal = _fee * _guestCount;
    BookSpot bookspot = BookSpot(
        userId: userId,
        date: _dateController.text,
        numberOfPeople: number_of_people,
        subtotal: subtotal,
        tourspotId: tourspotId;
    );

    try {
        final response = await api.postMethod(bookspot.toJson());

        if (response.statusCode == 200) {
          // Login successful
          var jsonResponse = jsonDecode(response.body);
          var user = jsonResponse['user'];
          var token = jsonResponse['tokens']['access'];

          Navigator.pushNamed(context, '/customer-homepage');
        } 
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 94.3, horizontal: 29),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Booking',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                    height: 1.2,
                    color: Color(0xFF1C2B38),
                  ),
                ),
              ),
              Divider(color: Color(0xFFF4F4F5), thickness: 1, height: 46.4),
              _buildSectionTitle('Select Date'),
              _buildDatePicker(),
              SizedBox(height: 27.2),
              _buildSectionTitle('No. Of Guest'),
              _buildGuestCounter(),
              SizedBox(height: 34.6),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Subtotal',
                      style: GoogleFonts.mulish(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF778088),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/vectors/vector_7_x2.svg',
                            width: 16.8, height: 20.3),
                        SizedBox(width: 8.5),
                        Text(
                          '${_fee * _guestCount}', // Use the converted fee here
                          style: GoogleFonts.mulish(
                            fontWeight: FontWeight.w400,
                            fontSize: 36,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 88.7),
              _buildConfirmButton(),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      letterSpacing: 0.6,
                      color: Color(0xFF7E7C7C),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11.3),
      child: Text(
        title,
        style: GoogleFonts.mulish(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          height: 1.2,
          color: Color(0xFF1C2B38),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          setState(() {
            _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(color: Color(0xFFF4F4F5)),
        padding: EdgeInsets.symmetric(vertical: 13.8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _dateController.text.isEmpty
                  ? 'Select a date'
                  : _dateController.text,
              style: GoogleFonts.mulish(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                height: 1.3,
                color: Color(0xFF495560),
              ),
            ),
            SvgPicture.asset('assets/vectors/bxbx_calendar_x2.svg',
                width: 18, height: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildGuestCounter() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13.8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _decrementGuest,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  '-',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 40),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 13.8, horizontal: 26),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xFFF4F4F5),
            ),
            child: Text(
              '$_guestCount Person',
              style: GoogleFonts.mulish(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                height: 1.3,
                color: Color(0xFF495560),
              ),
            ),
          ),
          SizedBox(width: 40),
          GestureDetector(
            onTap: _incrementGuest,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  '+',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: SECONDARY_COLOR,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 16.5),
      child: Center(
        child: Text(
          'Confirm Booking',
          style: GoogleFonts.mulish(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
