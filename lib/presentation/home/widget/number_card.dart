import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/constants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({super.key, required this.index, required this.imageurl});
  final int index;
  final String imageurl;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              height: 150,
            ),
            Container(
              width: 150,
              height: 210,
              decoration: BoxDecoration(
                borderRadius: kRadius15,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    imageurl,
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 6,
          bottom: -10,
          child: BorderedText(
            strokeColor: Colors.white,
            strokeWidth: 4.0,
            child: Text(
              "${index + 1}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 120,
                  decoration: TextDecoration.none,
                  decorationColor: Colors.black,
                  color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
