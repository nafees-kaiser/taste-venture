import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/widgets/customer_preference_grid.dart';
import 'package:frontend/widgets/preference_addtional_info.dart';

class CustomerPreferences extends StatefulWidget {
  @override
  _CustomerPreferencesState createState() => _CustomerPreferencesState();
}

class _CustomerPreferencesState extends State<CustomerPreferences> {
  List<String> selectedPreferences = <String>[];
  int itemSize = 5;

  int currentPage = 0;
  final int totalPage = 3;

  late Text heading = switch (currentPage) {
    1 => Text('Select your favourite food type'),
    2 => Text('Additional Information'),
    _ => Text('Select your favourite cuisinies')
  };

  late final firstPreference = CustomerPreferenceGrid(
      selectPreference: selectPreference, itemSize: itemSize);
  late final secondPreference = CustomerPreferenceGrid(
      selectPreference: selectPreference, itemSize: itemSize);

  late final preferenceAdditionalInfo = PreferenceAddtionalInfo();

  final List<String> allCuisineType = [
    'Italian',
    'Asian',
    'Western',
    'Bangla',
    'European'
  ];
  final List<String> allCuisineImage = [
    'assets/MargheritaPizza.jpg',
    'assets/SushiPlatter.jpg',
    'assets/rectangle_38.png',
    'assets/bangla_kachchi.jpg',
    'assets/GrilledSalmon.jpg'
  ];

  void selectPreference(int index) {
    setState(() {
      if (selectedPreferences.contains(allCuisineType[index])) {
        selectedPreferences.remove(allCuisineType[index]);
      } else {
        selectedPreferences.add(allCuisineType[index]);
      }
    });
    // print('|| $selectedPreferences ||');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // heading,
          switch (currentPage) {
            1 => Text('Select your favourite food type'),
            2 => Text('Additional Information'),
            _ => Text('Select your favourite cuisinies')
          },
          SizedBox(
            height: 25,
          ),
          Expanded(
              child: switch (currentPage) {
            1 => secondPreference,
            2 => preferenceAdditionalInfo,
            _ => firstPreference
          }),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: currentPage == 0
                    ? null
                    : () => setState(() {
                          currentPage--;
                        }),
                child: Text('Previous'),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (currentPage != totalPage - 1) {
                    setState(() {
                      currentPage++;
                    });
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Registration successful!',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    Navigator.pushNamed(context, '/login');
                  }
                },
                child:
                    currentPage != totalPage - 1 ? Text('Next') : Text('Done'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
