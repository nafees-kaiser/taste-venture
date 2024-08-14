import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewRestaurantCard extends StatefulWidget {
  const ViewRestaurantCard({
    super.key,
    required this.restaurants,
    required this.i,
  });

  final List<Map<String, dynamic>> restaurants;
  final int i;

  @override
  State<ViewRestaurantCard> createState() => _ViewRestaurantCardState();
}

class _ViewRestaurantCardState extends State<ViewRestaurantCard> {
  void toggleFavorite(int i) {
    setState(() {
      widget.restaurants[i]['favorite'] = !widget.restaurants[i]['favorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFFFFFFF),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            offset: Offset(0, 1),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              'assets/image.jpeg',
              fit: BoxFit.cover,
              height: 120,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 8, 6.7, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurants[widget.i]['name'],
                  style: GoogleFonts.getFont(
                    'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: const Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color.fromARGB(255, 2, 2, 2),
                      size: 22,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.restaurants[widget.i]['address'],
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: const Color(0xFF000000),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.1),
                Row(
                  children: [
                    RatingBar.builder(
                      ignoreGestures: true,
                      itemSize: 25,
                      allowHalfRating: true,
                      initialRating: (widget.restaurants[widget.i]['rating'] -
                                  widget.restaurants[widget.i]['rating']
                                      .floor()) !=
                              0.0
                          ? (widget.restaurants[widget.i]['rating'].floor() +
                              0.5)
                          : (widget.restaurants[widget.i]['rating']),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      onRatingUpdate: (double value) {},
                    ),
                    // for (int j = 0;
                    //     j < widget.restaurants[widget.i]['rating'];
                    //     j++)
                    //   SizedBox(
                    //       child:
                    //           SvgPicture.asset('assets/vectors/star_5_x2.svg'),
                    //       width: 22,
                    //       height: 22),

                    const SizedBox(width: 4.5),
                    Text(
                      '(${widget.restaurants[widget.i]['rating']})',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: Color(0xFF9B9B9B),
                      ),
                    ),

                    const Expanded(child: SizedBox()),

                    // Favorite
                    GestureDetector(
                      child: true //restaurants[i]['favorite']
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.pink,
                              size: 30,
                            )
                          : Icon(
                              Icons.favorite_border,
                              size: 30,
                            ),
                      onTap: () => toggleFavorite(widget.i),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
