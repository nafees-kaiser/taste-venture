import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
import 'package:intl/intl.dart';

class VisitingHistoryCard extends StatelessWidget {
  final String spotImage;
  final String spotName;
  final String spotLocation;
  final DateTime visitingDate;

  const VisitingHistoryCard({
    super.key, required this.spotImage, required this.spotName, required this.spotLocation, required this.visitingDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 80,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: SECONDARY_BACKGROUND,
                borderRadius: BorderRadius.circular(8),
              ),
              child:Image(image: AssetImage(spotImage)),
            ),
            SizedBox(width: 13),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    spotName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                      // SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          spotLocation,
                          style: TextStyle(
                            color: SECONDARY_BACKGROUND,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Visited on ${DateFormat('dd MMM, yyyy').format(visitingDate)}',
                    style: TextStyle(
                      color: SECONDARY_BACKGROUND,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, '/add-review'),
              child: Text('Add review'),
            ),
          ],
        ),
      ),
    );
  }
}
