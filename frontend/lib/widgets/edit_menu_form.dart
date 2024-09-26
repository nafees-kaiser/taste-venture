import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/flutter_toast.dart';
import 'package:frontend/widgets/custom_image_input.dart';
import 'package:frontend/widgets/information_card_without_icon.dart';
import 'package:image_input/image_input.dart';

class EditMenuForm extends StatefulWidget {
  Map<String, dynamic>? data;
  EditMenuForm({super.key, this.data});

  @override
  State<EditMenuForm> createState() => _EditMenuFormState();
}

class _EditMenuFormState extends State<EditMenuForm> {
  Map<String, dynamic>? data;
  List<XFile> image = [];
  // var api = ApiSettings(endPoint: 'restaurant/edit-menu');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      data = widget.data;
    });
  }

  Future<void> editData(String key, String value) async {
    var editData = {'id': data!['id'], key: value};

    try {
      final res =
          await ApiSettings(endPoint: 'restaurant/edit-menu/${data!['id']}')
              .postMethod(json.encode(editData));
      if (res.statusCode == 201 || res.statusCode == 200) {
        successToast("Menu edited successfully");
        Navigator.pop(context);
      } else {
        errorToast(
            "Error: ${res.statusCode}: Something went wrong! please try again");
      }
    } catch (e) {
      debugPrint(e.toString());
      errorToast("Something went wrong! please try again");
    }
  }

  Future<void> editImage() async {
    try {
      final res =
          await ApiSettings(endPoint: 'restaurant/edit-menu/${data!['id']}')
              .addPicture(image[0]);
      if (res.statusCode == 201 || res.statusCode == 200) {
        successToast("Image edited successfully");
        Navigator.pop(context);
      } else {
        errorToast(
            "Error: ${res.statusCode}: Something went wrong! please try again");
      }
    } catch (e) {
      debugPrint(e.toString());
      errorToast("Something went wrong! please try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: 7),
        InformationCardWithoutIcon(
          heading: 'Item name',
          text: data?['name'] ?? "Name",
          editKey: "name",
          action: editData,
        ),
        InformationCardWithoutIcon(
          heading: 'Item category',
          text: data?['category'] ?? "Category",
          editKey: "category",
          action: editData,
        ),
        InformationCardWithoutIcon(
          heading: 'Ingredients',
          text: data?['ingredients'] ?? "Ingredients",
          editKey: "ingredients",
          action: editData,
        ),
        InformationCardWithoutIcon(
          heading: 'Cuisine',
          text: data?['cuisine'] ?? "Cuisine",
          editKey: "cuisine",
          action: editData,
        ),
        InformationCardWithoutIcon(
          heading: 'Food type',
          text: data?['food_type'] ?? "Food type",
          editKey: "food_type",
          action: editData,
        ),
        InformationCardWithoutIcon(
          heading: 'Portion size',
          text: data?['size'] ?? "Portion size",
          editKey: "size",
          action: editData,
        ),

        InformationCardWithoutIcon(
          heading: 'Price',
          text: data?['price'] ?? "Price",
          editKey: "price",
          action: editData,
        ),

        InformationCardWithoutIcon(
          heading: 'Description',
          text: data?['description'] ?? "Description",
          editKey: "description",
          action: editData,
        ),
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
      ],
    );
  }
}
