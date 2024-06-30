import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/utils/custom_theme.dart';

class RestaurantDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: const Image(
                image: AssetImage('assets/yum-cha-district-banani.jpg')),
          ),
          SizedBox(height: 13),
          RestaurantHeading(theme: theme),
          SizedBox(height: 13),
          RestaurantTimeAndDistance(theme: theme),
          SizedBox(height: 13),
          DescAndButton(theme: theme),
        ],
      ),
    );
  }
}

class DescAndButton extends StatelessWidget {
  const DescAndButton({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
              'Welcome to Grand Restaurant, the ultimate destination for culinary adventurers and food enthusiasts! Nestled in the heart of the city, our restaurant offers an extraordinary dining experience that seamlessly blends the rich flavors of Italy with the exquisite tastes of Japan.'),
          SizedBox(height: 16),
          Container(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Reserve', style: TextStyle(fontSize: theme.buttonTextSize),),
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantTimeAndDistance extends StatelessWidget {
  const RestaurantTimeAndDistance({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconAndBelowText(
            theme: theme,
            icon: Icon(
              Icons.schedule,
              size: 40,
              color: HINT_TEXT_COLOR,
            ),
            text: Text(
              '10:00 AM - 08:00 PM',
              style: theme.textTheme.headlineSmall,
            ),
          ),
          // const VerticalDivider(color: Colors.black, width: 25,),
          IconAndBelowText(
            theme: theme,
            icon: Icon(
              Icons.location_on,
              size: 40,
              color: HINT_TEXT_COLOR,
            ),
            text: Text('1.5 km', style: theme.textTheme.headlineSmall),
          )
        ],
      ),
    );
  }
}

class RestaurantHeading extends StatelessWidget {
  const RestaurantHeading({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Yumcha District', style: theme.textTheme.headlineMedium),
                  Text('Banani, Dhaka'),
                ],
              ),
              // SizedBox(),
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
                    Text('4.7', style: TextStyle(color: Colors.white)),
                    Icon(
                      Icons.star_border_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class IconAndBelowText extends StatelessWidget {
  const IconAndBelowText(
      {super.key, required this.theme, required this.icon, required this.text});

  final ThemeData theme;
  final Icon icon;
  final Text text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [icon, text],
    );
  }
}
