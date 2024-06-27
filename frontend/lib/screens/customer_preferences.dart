import 'package:flutter/material.dart';

class CustomerPreferences extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preferences"),
      ),
      // body: SingleChildScrollView(child: RestaurantDetail()),
      body: PreferenceContent(),
    );
  }
}

class PreferenceContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          // childAspectRatio: 0.7,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                child: Image(
                  image: AssetImage('assets/pizza.jpg'),
                ),
                height: 115,
                // width: 300,
              ),
              SizedBox(height: 5),
              Text('French'),
            ],
          );
        },
        itemCount: 5,
      ),
    );
  }
}
