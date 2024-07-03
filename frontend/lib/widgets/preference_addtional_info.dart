import 'package:flutter/material.dart';
import 'package:frontend/utils/form_validation.dart';
import 'package:frontend/widgets/custom_dropdown_menu.dart';
import 'package:frontend/widgets/textbox.dart';

class PreferenceAddtionalInfo extends StatefulWidget {
  @override
  _PreferenceAddtionalInfoState createState() =>
      _PreferenceAddtionalInfoState();
}

class _PreferenceAddtionalInfoState extends State<PreferenceAddtionalInfo> {
  final _formKey = GlobalKey<FormState>();

  

  final controller = List<TextEditingController>.generate(
      5, (int index) => TextEditingController());

  final List<String> yesNoList = ['Yes', 'No'];
  final List<String> employmentList = ['Government', 'Non-government'];

  late final List<DropdownMenuEntry<String>> yesNoItems =
      yesNoList.map((toElement) {
    return DropdownMenuEntry(value: toElement, label: toElement);
  }).toList();

  late final List<DropdownMenuEntry<String>> employmentItems =
      employmentList.map((toElement) {
    return DropdownMenuEntry(value: toElement, label: toElement);
  }).toList();

  bool isButtonEnabled = false;

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
      print('*** ${i.text} ****');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDropdownMenu(
              controller: controller[0],
              menuItems: employmentItems,
              initialValue: employmentList[0],
              label: "Employment type",
            ),
            CustomDropdownMenu(
              controller: controller[1],
              menuItems: yesNoItems,
              initialValue: yesNoList[0],
              label: "Graduation complete",
            ),
            Textbox(
              label: 'Annual income',
              decoration: InputDecoration(
                hintText: 'eg 120000 Tk',
              ),
              validator: (value) => FormValidation()
                  .generalValidation(value, 'Please enter the annual income'),
              controller: controller[2],
            ),
            CustomDropdownMenu(
              controller: controller[3],
              menuItems: yesNoItems,
              initialValue: yesNoList[0],
              label: "Any chronic diseases",
            ),
            Textbox(
              label: 'Usual group member for a day tour',
              decoration: InputDecoration(
                hintText: 'eg 10',
              ),
              validator: (value) => FormValidation().generalValidation(
                  value, 'Please enter group member count'),
              controller: controller[4],
            ),
          ],
        ),
      ),
    );
  }
}
