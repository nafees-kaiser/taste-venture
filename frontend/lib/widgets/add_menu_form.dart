// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frontend/models/menu_item.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/flutter_toast.dart';
import 'package:frontend/utils/form_validation.dart';
import 'package:frontend/widgets/custom_image_input.dart';
import 'package:frontend/widgets/textbox.dart';
import 'package:image_input/image_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMenuForm extends StatefulWidget {
  final String endPoint;
  final Function? addMenuItems;
  final bool isAddRestaurant;
  const AddMenuForm({
    super.key,
    required this.endPoint,
    required this.addMenuItems,
    required this.isAddRestaurant,
  });

  @override
  _AddMenuFormState createState() => _AddMenuFormState();
}

class _AddMenuFormState extends State<AddMenuForm> {
  final _formKey = GlobalKey<FormState>();
  late ApiSettings api;
  late Function? addMenuItems;
  late bool isAddRestaurant;

  void _addMenu(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      MenuItem menuItem = MenuItem(
        name: controller[0].text,
        cuisine: "Bengali",
        food_type: "Fast food",
        ingredients: controller[2].text,
        description: controller[5].text,
        // image: image,
        price: controller[4].text,
        size: controller[3].text,
        category: controller[1].text,
      );

      if (isAddRestaurant) {
        addMenuItems!(menuItem);
        Navigator.pop(context);
      } else {
        SharedPreferences pref = await SharedPreferences.getInstance();
        final email = pref.get('userEmail');

        var data = menuItem.toMap();
        data['email'] = email;
        try {
          final response = await api.postMethod(jsonEncode(data));
          if (response.statusCode == 201 || response.statusCode == 200) {
            successToast("Menu added successfully");
            // Navigator.pushNamed(context, '/initial-menu');
            Navigator.pop(context, true);
          } else {
            errorToast("Error ${response.statusCode}: please try again");
          }
        } catch (e) {
          debugPrint(e.toString());
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text(e.toString())),
          // );
          errorToast("Something went wrong. Please try again");
        }
      }
    }
  }


  List<XFile> itemImage = [];
  bool isButtonEnabled = false;
  final controller = List<TextEditingController>.generate(
      6, (int index) => TextEditingController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addMenuItems = widget.addMenuItems;
    isAddRestaurant = widget.isAddRestaurant;
    api = ApiSettings(endPoint: widget.endPoint);
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

  void _enableOrDesableButton() {
    for (final i in controller) {
      if (i.text.isEmpty || itemImage.isEmpty) {
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
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Textbox(
                    label: 'Item name',
                    decoration: InputDecoration(
                      hintText: 'Give a short meaningful name',
                    ),
                    validator: (value) => FormValidation()
                        .generalValidation(value, 'Please enter a item name'),
                    controller: controller[0],
                  ),
                  Textbox(
                    label: 'Item category',
                    decoration: InputDecoration(
                      hintText: 'eg Main dish',
                    ),
                    validator: (value) => FormValidation()
                        .generalValidation(value, 'Please enter the category'),
                    controller: controller[1],
                  ),
                  Textbox(
                    label: 'Ingredients',
                    decoration: InputDecoration(
                      hintText: 'Write ingredients comma separated',
                    ),
                    validator: (value) => FormValidation().generalValidation(
                        value, 'Please enter the ingredients'),
                    controller: controller[2],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Textbox(
                          label: 'Portion size',
                          decoration: InputDecoration(
                            hintText: 'eg 1:2, 1 pc',
                          ),
                          validator: (value) => FormValidation()
                              .generalValidation(
                                  value, 'Please enter the portion size'),
                          controller: controller[3],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Textbox(
                          label: 'Price',
                          decoration: InputDecoration(
                            hintText: 'eg 1000 Tk',
                          ),
                          validator: (value) => FormValidation()
                              .generalValidation(
                                  value, 'Please enter the price of the item'),
                          controller: controller[4],
                        ),
                      ),
                    ],
                  ),
                  Textbox(
                    label: 'Description',
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Enter a short description of your item',
                    ),
                    validator: (value) => FormValidation().generalValidation(
                        value, 'Please enter the description'),
                    controller: controller[5],
                  ),
                  // Textbox(
                  //   label: 'Picture',
                  //   decoration: InputDecoration(
                  //     hintText: 'Formats jpg, jpeg, png, svg',
                  //   ),
                  //   validator: (value) => FormValidation().generalValidation(
                  //       value, 'Please enter one picture of the item'),
                  //   controller: controller[6],
                  // ),
                  // ImageInput(
                  //   images: itemImage,
                  //   onImageSelected: (value) => setState(() {
                  //     itemImage.add(value);
                  //   }),
                  //   onImageRemoved: (image, index) => setState(() {
                  //     itemImage.remove(image);
                  //   }),
                  // ),
                  CustomImageInput(
                    label: 'Picture',
                    inputImage: itemImage,
                    onImageSelected: (value) {
                      setState(() {
                        itemImage.add(value);
                      });
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
                    },
                    onImageRemoved: (image, index) => setState(() {
                      itemImage.remove(image);
                      isButtonEnabled = false;
                    }),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: isButtonEnabled ? () => _addMenu(context) : null,
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
