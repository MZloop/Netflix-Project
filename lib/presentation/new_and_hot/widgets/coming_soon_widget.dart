import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/colors/constants.dart';
import 'package:netflix_app/presentation/home/widget/custom_button.dart';
import 'package:netflix_app/presentation/widgets/video_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String description;

  const ComingSoonWidget({
    super.key,
    required this.id,
    required this.month,
    required this.day,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(month,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kgreyColor)),
              Text(
                day,
                style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              )
            ],
          ),
        ),
        SizedBox(
          width: size.width - 50,
          height: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              videoWidget(url: posterPath),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      movieName,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                          letterSpacing: 0,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const Row(
                    children: [
                      CustomButton(
                        icon: Icons.notifications,
                        title: "Remind me",
                        iconSize: 24,
                        textSize: 12,
                      ),
                      KWidth15,
                      CustomButton(
                        icon: Icons.info_outlined,
                        title: "info",
                        iconSize: 24,
                        textSize: 12,
                      ),
                      KWidth,
                    ],
                  )
                ],
              ),
              KHeight6,
              Text("Released on $day $month"),
              KHeight,
              Text(
                movieName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              KHeight,
              Text(
                description,
                maxLines: 4,
                style: const TextStyle(color: kgreyColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
