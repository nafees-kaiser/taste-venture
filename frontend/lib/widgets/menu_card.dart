import 'package:flutter/material.dart';
import 'package:frontend/utils/custom_theme.dart';

class MenuCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 19, vertical: 23),
      child: Row(children: [
        Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            // Flexible(child: const Image(image: AssetImage('assets/pizza.jpg')), fit: FlexFit.loose,),
            Container(
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
                    Text('340 Taka', style: TextStyle(color: Colors.white)),
                    Icon(
                      Icons.star_border_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(width: 9),
        Column(
          children: [
            Text('Nigiri Sushi', style: theme.textTheme.headlineSmall),
            Text('Fresh slices of fish or seafood atop vinegared rice.', style: theme.textTheme.bodyMedium),
          ],
        )
      ],),
    );
  }
  
}