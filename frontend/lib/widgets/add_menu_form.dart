import 'package:flutter/material.dart';
import 'package:frontend/utils/form_validation.dart';
import 'package:frontend/widgets/custom_image_input.dart';
import 'package:frontend/widgets/textbox.dart';

import 'package:image_input/image_input.dart';

class AddMenuForm extends StatefulWidget {
  const AddMenuForm({
    super.key,
  });

  @override
  _AddMenuFormState createState() => _AddMenuFormState();
}

class _AddMenuFormState extends State<AddMenuForm> {
  final _formKey = GlobalKey<FormState>();

  List<XFile> itemImage = [];
  bool isButtonEnabled = false;
  final controller = List<TextEditingController>.generate(
      7, (int index) => TextEditingController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                    onImageSelected: (value) => setState(() {
                      itemImage.add(value);
                    }),
                    onImageRemoved: (image, index) => setState(() {
                      itemImage.remove(image);
                    }),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: isButtonEnabled
                ? () {
                    // after adding the menu item
                    if (_formKey.currentState!.validate()) {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Processing Data')),
                      // );
                      Navigator.pushNamed(context, '/initial-menu');
                    }
                  }
                : null,
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
