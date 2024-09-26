import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/utils/flutter_toast.dart';
import 'package:frontend/widgets/custom_image_input.dart';
import 'package:frontend/widgets/information_card.dart';
import 'package:frontend/widgets/manager_sidebar.dart';
import 'package:image_input/image_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagerRestaurantInformation extends StatefulWidget {
  const ManagerRestaurantInformation({super.key});
  @override
  State<ManagerRestaurantInformation> createState() =>
      _ManagerRestaurantInformationState();
}

class _ManagerRestaurantInformationState
    extends State<ManagerRestaurantInformation> {
  late ApiSettings getAPI, postAPI;

  late Future<Map<String, dynamic>> _bookingFuture;

  List<XFile> image = [];

  @override
  void initState() {
    super.initState();
    _bookingFuture = _initializeData();
  }

  Future<Map<String, dynamic>> _initializeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String restaurantID = prefs.getInt('spotId').toString();
    getAPI = ApiSettings(endPoint: 'restaurant/$restaurantID');
    postAPI =
        ApiSettings(endPoint: 'restaurant/edit-restaurant/$restaurantID/');
    return getInfo();
  }

  Future<Map<String, dynamic>> getInfo() async {
    final response = await getAPI.getMethod();
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> restaurantInfo = jsonDecode(response.body);
        print(restaurantInfo);
        return restaurantInfo;
      } else {
        throw Exception('Failed to load Restaurant Information');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> editImage() async {
    try {
      final res = await postAPI.addPicture(image[0]);
      if (res.statusCode == 201 || res.statusCode == 200) {
        successToast("Image edited successfully");
        // Navigator.pop(context);
        setState(() {
          
        });
      } else {
        errorToast(
            "Error: ${res.statusCode}: Something went wrong! please try again");
      }
    } catch (e) {
      debugPrint(e.toString());
      errorToast("Something went wrong! please try again");
    }
  }

  void _saveChanges(String key, String newValue) async {
    final response = await postAPI.postMethod(jsonEncode({key: newValue}));
    try {
      if (response.statusCode == 200) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Updated successfully')),
        // );
        successToast("Information updated successfully");
        // Refresh the page
        setState(() {
          _bookingFuture = _initializeData();
        });
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Error updating data')),
        // );
        errorToast("Error updating data");
      }
    } catch (e) {
      errorToast("Something went wrong! Try again later");
      throw Exception(e);
    }
  }

  Future<String?> _showTextInputDialog(
      BuildContext context, String title, String initialValue) {
    TextEditingController controller =
        TextEditingController(text: initialValue);
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $title'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter new $title'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTimeCard(BuildContext context, String label, String time) {
    return GestureDetector(
      onTap: () async {
        // Parse the time string to TimeOfDay
        final parsedTime = TimeOfDay(
          hour: int.parse(time.split(':')[0]),
          minute: int.parse(time.split(':')[1].split(' ')[0]),
        );

        TimeOfDay? newTimeOfDay = await showTimePicker(
            context: context,
            initialTime: parsedTime,
            initialEntryMode: TimePickerEntryMode.inputOnly);
        if (newTimeOfDay != null && newTimeOfDay.toString().isNotEmpty) {
          _saveChanges(label == "From" ? 'opening_time' : 'closing_time',
              "${newTimeOfDay.hour}:${newTimeOfDay.minute.toString().padLeft(2, '0')} ${newTimeOfDay.period.name}");
        }
      },
      child: Container(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ManagerSidebar(),
      appBar: AppBar(
        title: const Text(
          "Restaurant information",
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _bookingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final restaurantInfo = snapshot.data!;
            return SingleChildScrollView(
              child: Container(
                padding: Theme.of(context).largemainPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    InformationCard(
                        heading: "Restaurant Name",
                        text: restaurantInfo['restaurant_name'],
                        onTextSaved: (newValue) {
                          _saveChanges('restaurant_name', newValue);
                        }),
                    InformationCard(
                        heading: "Manager Name",
                        text: restaurantInfo['name'],
                        onTextSaved: (newValue) {
                          _saveChanges('name', newValue);
                        }),
                    InformationCard(
                        heading: "Official Email",
                        text: restaurantInfo['email'],
                        onTextSaved: (newValue) {
                          _saveChanges('email', newValue);
                        }),
                    InformationCard(
                        heading: "Address",
                        text: restaurantInfo['address'],
                        onTextSaved: (newValue) {
                          _saveChanges('address', newValue);
                        }),
                    InformationCard(
                        heading: "Phone Number",
                        text: restaurantInfo['contact'],
                        onTextSaved: (newValue) {
                          _saveChanges('contact', newValue);
                        }),
                    InformationCard(
                        heading: "Cuisine",
                        text: restaurantInfo['cuisine'],
                        onTextSaved: (newValue) {
                          _saveChanges('cuisine', newValue);
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Usual open time range",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimeCard(
                            context, "From", restaurantInfo['opening_time']),
                        _buildTimeCard(
                            context, "To", restaurantInfo['closing_time']),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InformationCard(
                      heading: "Description",
                      text: restaurantInfo['description'],
                      onTextSaved: (newText) =>
                          restaurantInfo['description'] = newText,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // InformationCard(
                    //   heading: "Image",
                    //   text: "Gaming Zone, Cleaning Service",
                    // ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        CustomImageInput(
                          label: 'Change picture',
                          inputImage: image,
                          onImageSelected: (value) {
                            setState(() {
                              image.add(value);
                            });
                          },
                          onImageRemoved: (img, index) => setState(() {
                            image.remove(img);
                          }),
                        ),
                        SizedBox(height: 10),
                        if (image.isNotEmpty) ...[
                          ElevatedButton(
                            onPressed: () {
                              editImage();
                            },
                            child: Text('Update'),
                          )
                        ],
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
