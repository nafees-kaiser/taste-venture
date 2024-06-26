import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/utils/custom_theme.dart';

class MenuCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: BORDER_COLOR),
        borderRadius: BorderRadius.circular(7)
      ),
      // width: 330,
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 19, vertical: 23),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    // padding: EdgeInsets.fromLTRB(0, 0, 5, 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7)
                    ),
                    child: const Image(image: AssetImage('assets/pizza.jpg')),
                  ),
                  Positioned(
                    bottom: -10,
                    right: -25,
                    child: Container(
                      padding: theme.defaultPadding,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(13),
                          bottomRight: Radius.circular(13),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text('340 Taka',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              // Flexible(child: const Image(image: AssetImage('assets/pizza.jpg')), fit: FlexFit.loose,),
            ],
          ),
          SizedBox(width: 9),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nigiri Sushi', style: theme.textTheme.headlineSmall),
                Expanded(
                  child: Text(
                    'Fresh slices of fish or seafood atop vinegared rice.',
                    style: theme.textTheme.bodyMedium,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
