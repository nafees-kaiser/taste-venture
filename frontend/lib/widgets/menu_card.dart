import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/models/menu_item.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:image_input/image_input.dart';

class MenuCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: BORDER_COLOR),
          borderRadius: BorderRadius.circular(7)),
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(7)),
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

class MenuCard2 extends StatefulWidget {
  // final MenuItem menuItem;
  final Map<String, dynamic> menuItem;
  var image;
  MenuCard2({super.key, required this.menuItem, this.image});

  @override
  State<MenuCard2> createState() => _MenuCard2State();
}

class _MenuCard2State extends State<MenuCard2> {
  var image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.menuItem['image'] != null && widget.menuItem['image'] is String) {
      setState(() {
        // if (image is String) {
        //   image = ApiSettings(endPoint: widget.image).getUri();
        // }
        var imageUrl = widget.menuItem['image'] as String;
        imageUrl = imageUrl.substring(1);
        image = ApiSettings(endPoint: imageUrl).getUri();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      // height: ,
      constraints: BoxConstraints(minHeight: 130),
      decoration: BoxDecoration(
          border: Border.all(color: BORDER_COLOR),
          borderRadius: BorderRadius.circular(7)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            // padding: EdgeInsets.fromLTRB(0, 0, 5, 5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
            // constraints: BoxConstraints(),
            width: 80,
            height: 80,
            child: widget.menuItem['image'] == null
                ? const Image(
                    image: AssetImage('assets/image_filler.png'),
                    fit: BoxFit.cover,
                  )
                : widget.menuItem['image'] is String
                    ? Image.network(
                       image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Image(
                          image: AssetImage('assets/image_filler.png'),
                          fit: BoxFit.cover,
                        ),
                      )
                    : 
                    Image.file(
                        File(widget.menuItem['image']!.path),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Image(
                          image: AssetImage('assets/image_filler.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.menuItem['name'],
                    style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: 3),
                // Flexible(
                // child:
                Text(
                  widget.menuItem['description'],
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
                // ),
                SizedBox(height: 7),
                // Expanded(
                // child:
                Text(
                  widget.menuItem['price'] + " Taka",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
