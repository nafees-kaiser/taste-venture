import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/widgets/information_card.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:http/http.dart' as http;
import 'package:frontend/utils/api_settings.dart';

// Function to fetch tour spot details
Future<Map<String, dynamic>> fetchTourSpotDetails(int id) async {
  ApiSettings api = ApiSettings(endPoint: 'tourspot/view-list/$id');
  final response = await api.getMethod();
  return json.decode(response.body);
}

// Function to post updated tour spot details
Future<http.Response> postUpdateTourSpot(
    int id, Map<String, dynamic> data) async {
  ApiSettings api = ApiSettings(endPoint: 'tourspot/edit-tourspot/$id');
  return api.postMethod(json.encode(data));
}

class ManagerVenueInformation extends StatefulWidget {
  const ManagerVenueInformation({super.key});

  @override
  State<ManagerVenueInformation> createState() =>
      _ManagerVenueInformationState();
}

class _ManagerVenueInformationState extends State<ManagerVenueInformation> {
  late Future<Map<String, dynamic>> venueDetailsFuture;
  late int spotId;
  late Map<String, dynamic> updatedData;

  @override
  void initState() {
    super.initState();
    venueDetailsFuture = _getSpotIdAndFetchDetails();
  }

  Future<Map<String, dynamic>> _getSpotIdAndFetchDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    spotId = prefs.getInt('spotId') ?? 0;
    return fetchTourSpotDetails(spotId);
  }

  void _saveChanges(String key, String newValue) {
    setState(() {
      updatedData[key] = newValue;
    });
    _updateTourSpot();
  }

  Future<void> _updateTourSpot() async {
    final response = await postUpdateTourSpot(spotId, updatedData);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error updating data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Venue Information"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: venueDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found.'));
          }

          final data = snapshot.data!;
          final venueName = data['tourspot_name'] ?? 'N/A';
          final managerName = data['name'] ?? 'N/A';
          final email = data['email'] ?? 'N/A';
          final address = data['address'] ?? 'N/A';
          final phoneNumber = data['contact'] ?? 'N/A';
          final entranceFee = data['entry_fee'] ?? 'N/A';
          final openTime = data['opening_time'] ?? 'N/A';
          final closeTime = data['closing_time'] ?? 'N/A';
          final description = data['description'] ?? 'N/A';
          final wifiAvailable = data['wifi'] == true ? 'Yes' : 'No';
          final parkingAvailable = data['parking'] == true ? 'Yes' : 'No';
          final foodAvailable = data['food'] == true ? 'Yes' : 'No';
          final indoorPoolAvailable = data['pool'] == true ? 'Yes' : 'No';
          final otherServices = data['other_services'] ?? 'N/A';

          updatedData = {
            'tourspot_name': venueName,
            'opening_time': openTime,
            'closing_time': closeTime,
            'description': description,
            'entry_fee': entranceFee,
            'wifi': wifiAvailable,
            'parking': parkingAvailable,
            'food': foodAvailable,
            'pool': indoorPoolAvailable,
            'other_services': otherServices,
          };

          return SingleChildScrollView(
            child: Container(
              padding: Theme.of(context).largemainPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  InformationCard(
                    heading: "Venue Name",
                    text: venueName,
                    onTextSaved: (newText) =>
                        _saveChanges('tourspot_name', newText),
                  ),
                  InformationCard(
                    heading: "Manager Name",
                    text: managerName,
                    onTextSaved: (newText) => _saveChanges('name', newText),
                  ),
                  InformationCard(
                    heading: "Official Email",
                    text: email,
                    onTextSaved: (newText) => _saveChanges('email', newText),
                  ),
                  InformationCard(
                    heading: "Address",
                    text: address,
                    onTextSaved: (newText) => _saveChanges('address', newText),
                  ),
                  InformationCard(
                    heading: "Phone Number",
                    text: phoneNumber,
                    onTextSaved: (newText) => _saveChanges('contact', newText),
                  ),
                  InformationCard(
                    heading: "Entrance Fee",
                    text: entranceFee,
                    onTextSaved: (newText) =>
                        _saveChanges('entry_fee', newText),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Usual open time range",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTimeCard(context, "From", openTime),
                      _buildTimeCard(context, "To", closeTime),
                    ],
                  ),
                  const SizedBox(height: 10),
                  InformationCard(
                    heading: "Description",
                    text: description,
                    onTextSaved: (newText) =>
                        _saveChanges('description', newText),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFeatureCard(context, "Free WiFi", wifiAvailable),
                      _buildFeatureCard(context, "Parking", parkingAvailable),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFeatureCard(context, "Food", foodAvailable),
                      _buildFeatureCard(
                          context, "Indoor Pool", indoorPoolAvailable),
                    ],
                  ),
                  const SizedBox(height: 10),
                  InformationCard(
                    heading: "Other Services",
                    text: otherServices,
                    onTextSaved: (newText) =>
                        _saveChanges('other_services', newText),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeCard(BuildContext context, String label, String time) {
    return Container(
      width: 170,
      margin: Theme.of(context).subSectionDividerPadding,
      padding: Theme.of(context).insideCardPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(2, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.edit,
            size: 20.0,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, String feature, String available) {
    return Container(
      width: 170,
      margin: Theme.of(context).subSectionDividerPadding,
      padding: Theme.of(context).insideCardPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(2, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feature,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              Text(
                available,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.edit,
            size: 20.0,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
