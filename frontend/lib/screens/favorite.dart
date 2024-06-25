import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorites"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 240,
                  padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Card.outlined(
                    borderOnForeground: true,
                    clipBehavior: Clip.hardEdge,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/JeansCakes.png',
                            width: 328,
                            height: 150,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 1.0),
                          child: Text("Favorite 1",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Text("Favorite 2",
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
