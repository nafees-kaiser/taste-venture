import 'package:flutter/material.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';
import 'package:intl/intl.dart';
import 'package:frontend/models/reservation.dart';
import 'package:flutter/services.dart';

class CustomerReservation extends StatefulWidget {
  const CustomerReservation({super.key});

  @override
  State<CustomerReservation> createState() => _CustomerReservationState();
}

class _CustomerReservationState extends State<CustomerReservation> {
  // API integration
  ApiSettings api = ApiSettings(endPoint: 'users/login');
  Future<void> addReservation() async {
    Reservation reservation = Reservation(
      userId: 1000,
      restaurantId: 7,
      date: dateController.text,
      startTime: _selectedTime, // TODO: Convert to time format
      endTime: _selectedTime, // TODO: Convert to time format
      reservationType: 1,
      numberOfPeople: int.parse(numberOfPeopleController.text),
    );

    try {
      final response = await api.postMethod(
        reservation.toJson(),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  // variables
  TextEditingController dateController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController numberOfPeopleController = TextEditingController();
  String? _selectedOption = "Select option";
  String? _selectedTime = "Select time";
  bool _showCustomTextBox = false;

  final List<String> _timeOptions = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM'
  ];

  //methods
  @override
  void initState() {
    super.initState();
    _selectedTime = _timeOptions.first; // Set the initial selected time
  }

  Text titleText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate() async {
      DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100));

      if (date != null) {
        setState(() {
          dateController.text = DateFormat("dd/MM/yyyy").format(date);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservation Information"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: titleText("Date:"),
            ),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Date',
                suffixIcon: Icon(Icons.date_range),
              ),
              onTap: () {
                selectDate();
              },
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: titleText("Time:"),
            ),
            DropdownButtonFormField<String>(
              value: _selectedTime,
              items: _timeOptions.map((String time) {
                return DropdownMenuItem<String>(
                  value: time,
                  child: Text(time),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTime = newValue!;
                });
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: titleText("Duration:"),
            ),
            TextField(
              controller: durationController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'How long do you wish to stay?',
              ),
            ),

            // Reserve checkbox
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: titleText('Reserve:'),
            ),
            Row(children: [
              Radio<String>(
                value: 'Full Restaurant',
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value;
                    _showCustomTextBox = false;
                  });
                },
              ),
              const Text(
                'Full Restaurant',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ]),
            const SizedBox(width: 16),
            Row(
              children: [
                Radio<String>(
                  value: 'Custom',
                  groupValue: _selectedOption,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedOption = value;
                      _showCustomTextBox = true;
                    });
                  },
                ),
                const Text(
                  'Custom',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            if (_showCustomTextBox)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextField(
                  controller: numberOfPeopleController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the number of people',
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 20.0),
              child: SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: const Text(
                    "Reserve",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
