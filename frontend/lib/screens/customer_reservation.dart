import 'package:flutter/material.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';
import 'package:intl/intl.dart';
import 'package:frontend/models/reservation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerReservation extends StatefulWidget {
  final int restaurantId;

  const CustomerReservation({Key? key, required this.restaurantId})
      : super(key: key);

  @override
  State<CustomerReservation> createState() => _CustomerReservationState();
}

class _CustomerReservationState extends State<CustomerReservation> {
  ApiSettings api = ApiSettings(endPoint: 'restaurant/add-reservation');
  Future<void> addReservation() async {
    TimeOfDay? startTimeOfDay;
    for (var timeOption in _timeOptions) {
      if (timeOption.keys.first == _selectedTime) {
        startTimeOfDay = timeOption.values.first;
        break;
      }
    }

    if (startTimeOfDay != null) {
      final now = DateTime.now();
      final startTime = DateTime(now.year, now.month, now.day,
          startTimeOfDay.hour, startTimeOfDay.minute);

      int duration =
          int.parse(durationController.text); // Assuming user enters hours
      final endTime = startTime.add(Duration(hours: duration));

      String formattedStartTime = DateFormat('HH:mm:ss').format(startTime);
      String formattedEndTime = DateFormat('HH:mm:ss').format(endTime);
      String formattedDate = DateFormat('yyyy-MM-dd')
          .format(DateFormat('dd/MM/yyyy').parse(dateController.text));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? restaurantId = widget.restaurantId;
      int? userId = int.tryParse(prefs.getString('userId') ?? '');

      Reservation reservation = Reservation(
        userId: userId,
        restaurantId: restaurantId,
        date: formattedDate,
        startTime: formattedStartTime, // Start time in the required format
        endTime:
            formattedEndTime, // Use the same time or calculate end time based on duration
        reservationType: 1,
        numberOfPeople: int.tryParse(numberOfPeopleController.text) ?? 0,
      );
      print(reservation.toJson());

      try {
        final response = await api.postMethod(
          reservation.toJson(),
        );
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  // variables
  TextEditingController dateController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController numberOfPeopleController = TextEditingController();
  String? _selectedOption = "Select option";
  String? _selectedTime = "Select time";
  bool _showCustomTextBox = false;

  final List<Map<String, TimeOfDay>> _timeOptions = [
    {'9:00 AM': const TimeOfDay(hour: 9, minute: 0)},
    {'10:00 AM': const TimeOfDay(hour: 10, minute: 0)},
    {'11:00 AM': const TimeOfDay(hour: 11, minute: 0)},
    {'12:00 PM': const TimeOfDay(hour: 12, minute: 0)},
    {'1:00 PM': const TimeOfDay(hour: 13, minute: 0)},
    {'2:00 PM': const TimeOfDay(hour: 14, minute: 0)}
  ];
  //methods
  @override
  void initState() {
    super.initState();
    _selectedTime =
        _timeOptions.first.keys.first; // Set the initial selected time
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
              items: _timeOptions.map((time) {
                String timeKey = time
                    .keys.first; // Get the first (and only) key from the map
                return DropdownMenuItem<String>(
                  value: timeKey,
                  child: Text(timeKey),
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
                hintText: 'How many hours do you wish to stay?',
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
                  onPressed: () {
                    addReservation();
                  },
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
