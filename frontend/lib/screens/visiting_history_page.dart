import 'package:flutter/material.dart';
import 'package:frontend/widgets/visiting_history.dart';

class VisitingHistoryPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visiting history"),
      ),
      body: VisitingHistory(),
    );
  }
  
}