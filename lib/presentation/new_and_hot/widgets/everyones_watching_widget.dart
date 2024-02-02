import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/colors/constants.dart';
import 'package:netflix_app/presentation/home/widget/custom_button.dart';
import 'package:netflix_app/presentation/widgets/video_widgetnew.dart';

class EveryonesWatchingWidget extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;
  const EveryonesWatchingWidget({
    super.key,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KHeight,
        KHeight,
        Text(
          movieName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        KHeight,
        Text(
          description,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: kgreyColor),
        ),
        KHeight50,
        videoWidgetNew(url: posterPath),
        KHeight,
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButton(
              icon: Icons.send,
              title: "Share",
              iconSize: 23,
              textSize: 12,
            ),
            KWidth14,
            CustomButton(
              icon: Icons.add,
              title: "My List",
              iconSize: 24,
              textSize: 12,
            ),
            KWidth14,
            CustomButton(
              icon: Icons.play_arrow,
              title: "Play",
              iconSize: 26,
              textSize: 12,
            ),
            KWidth14
          ],
        )
      ],
    );
  }
}
