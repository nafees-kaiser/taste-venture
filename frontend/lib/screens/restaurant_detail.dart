import 'package:flutter/material.dart';
import 'package:frontend/screens/customer_reservation.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/utils/custom_theme.dart';

class RestaurantDetail extends StatelessWidget {
  final data;

  const RestaurantDetail({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                // height: 200,
                constraints: BoxConstraints(minHeight: 200),
                child: data['image'] == null
                    ? const Image(
                        image: AssetImage('assets/image_filler.png'),
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        ApiSettings(endPoint: data['image']).getUri(),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Image(
                          image: AssetImage('assets/image_filler.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              Positioned(
                bottom: 15,
                right: 20,
                child: Container(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerReservation(restaurantId: data['id']),
                        ),
                      );
                    },
                    child: Text(
                      'Reserve',
                      style: TextStyle(fontSize: theme.buttonTextSize),
                    ),
                  ),
                ),
              )
            ],
          ),
          // Container(
          //   child: const Image(
          //       image: AssetImage('assets/yum-cha-district-banani.jpg')),
          // ),
          SizedBox(height: 13),
          RestaurantHeading(theme: theme, data: data),
          SizedBox(height: 13),
          RestaurantTimeAndDistance(theme: theme, data: data),
          SizedBox(height: 13),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
                // 'Welcome to Grand Restaurant, the ultimate destination for culinary adventurers and food enthusiasts! Nestled in the heart of the city, our restaurant offers an extraordinary dining experience that seamlessly blends the rich flavors of Italy with the exquisite tastes of Japan.'
                data['description']),
          ),
          SizedBox(height: 16),
          // DescAndButton(theme: theme),
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
              onPressed: () =>
                  Navigator.pushNamed(context, '/customer/reservation'),
              child: Text(
                'Reserve',
                style: TextStyle(fontSize: theme.buttonTextSize),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantTimeAndDistance extends StatelessWidget {
  final data;
  const RestaurantTimeAndDistance({
    super.key,
    required this.theme,
    required this.data,
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
              color: SECONDARY_BACKGROUND,
            ),
            text: Text(
              // '10:00 AM - 08:00 PM',
              data['opening_time'] + ' - ' + data['closing_time'],
              style: theme.textTheme.headlineSmall,
            ),
          ),
          // const VerticalDivider(color: Colors.black, width: 25,),
          // IconAndBelowText(
          //   theme: theme,
          //   icon: Icon(
          //     Icons.location_on,
          //     size: 40,
          //     color: SECONDARY_BACKGROUND,
          //   ),
          //   text: Text('1.5 km', style: theme.textTheme.headlineSmall),
          // )
        ],
      ),
    );
  }
}

class RestaurantHeading extends StatelessWidget {
  final data;
  const RestaurantHeading({
    super.key,
    required this.theme,
    required this.data,
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
                  Text(data['restaurant_name'],
                      style: theme.textTheme.headlineMedium),
                  Text(data['address']),
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
                    Text(data['rating'].toString(),
                        style: TextStyle(color: Colors.white)),
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
