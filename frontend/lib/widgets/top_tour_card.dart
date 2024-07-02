import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';

class TopTourCard extends StatefulWidget {
  String tourImage, tourName, tourAddress, tourURL;
  TopTourCard({
    super.key,
    required this.tourImage,
    required this.tourName,
    required this.tourAddress,
    required this.tourURL,
  });

  @override
  State<TopTourCard> createState() => _TopTourCardState();
}

class _TopTourCardState extends State<TopTourCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 115,
      child: Card.outlined(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: DISABLE, width: 1.0),
          ),
          color: BACKGROUND,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),

                  // Image
                  child: Image.asset(
                    widget.tourImage,
                    width: 80,
                    height: 80,
                    fit: BoxFit.fitHeight,
                  ),
                ),

                // Spot Details
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Spot Name
                      SizedBox(
                        width: 130,
                        child: Text(
                          widget.tourName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const Expanded(child: SizedBox()),

                      // Spot address
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 13, color: Colors.black),
                          SizedBox(
                            width: 130,
                            child: Text(
                              widget.tourAddress,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: 75,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SECONDARY_COLOR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/tour_spot/information'),
                    child: const Text(
                      "View",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
