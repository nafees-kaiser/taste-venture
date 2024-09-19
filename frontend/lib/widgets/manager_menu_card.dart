import 'package:flutter/material.dart';
import 'package:frontend/utils/api_settings.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:image_input/image_input.dart';

class ManagerMenuCard extends StatefulWidget {
  final String? image;
  final String heading, description, price;
  const ManagerMenuCard(
      {super.key,
      this.image,
      required this.heading,
      required this.description,
      required this.price});

  @override
  State<ManagerMenuCard> createState() => _ManagerMenuCardState();
}

class _ManagerMenuCardState extends State<ManagerMenuCard> {
  String? imageUri;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.image != null && widget.image!.isNotEmpty) {
      setState(() {
        imageUri = ApiSettings(endPoint: widget.image!).getUri();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Theme.of(context).subSectionDividerPadding,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imageUri == null
                    ? const Image(
                        image: AssetImage('assets/image_filler.png'),
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        imageUri!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Image(
                            image: AssetImage('assets/image_filler.png'),
                            fit: BoxFit.cover,
                          ); // Handle error
                        },
                      ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.heading,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.price,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
