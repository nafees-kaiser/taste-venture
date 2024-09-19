import 'package:flutter/material.dart';
import 'package:frontend/widgets/edit_menu_form.dart';

class EditMenuPage extends StatelessWidget{
  Map<String, dynamic>? data;

  EditMenuPage({super.key, this.data});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit menu"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: EditMenuForm(data: data),
      ),
    ); 
  }

}