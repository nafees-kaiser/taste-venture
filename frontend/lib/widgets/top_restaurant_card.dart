import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';

class TopResCard extends StatelessWidget {
  String restaurantImage, restaurantName, restaurantAddress;
  double restaurantRating;
  TopResCard(
      {super.key,
      required this.restaurantImage,
      required this.restaurantName,
      required this.restaurantAddress,
      required this.restaurantRating});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 170,
        height: 220,
        child: Card.outlined(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              side: BorderSide(
                color: DISABLE,
                width: 1,
              )),
          color: BACKGROUND,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    restaurantImage,
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 0.0),
                child: SizedBox(
                  width: 130,
                  child: Text(
                    restaurantName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 4.0, 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 13, color: Colors.black),
                    SizedBox(
                      width: 130,
                      child: Text(
                        restaurantAddress,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 2.0, 4.0, 0.0),
                child: Row(
                  children: [
                    const Icon(Icons.star, size: 13, color: Colors.black),
                    Text(
                      restaurantRating.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
