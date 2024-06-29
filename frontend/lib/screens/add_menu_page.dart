import 'package:flutter/material.dart';
import 'package:frontend/widgets/textbox.dart';

class AddMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add menu"),
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: AddMenuForm(),
      )),
    );
  }
}

class AddMenuForm extends StatefulWidget {
  const AddMenuForm({
    super.key,
  });

  @override
  _AddMenuFormState createState() => _AddMenuFormState();
}

class _AddMenuFormState extends State<AddMenuForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Item name', style: Theme.of(context).textTheme.titleMedium,),
            Textbox(
              decoration: InputDecoration(
                hintText: 'Give a short meaningful name',
              ),
            ),
          ],
        ),
      );
    
  }
}
