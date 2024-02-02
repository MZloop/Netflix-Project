import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/constants.dart';
import 'package:netflix_app/presentation/widgets/main_card.dart';
import 'package:netflix_app/presentation/widgets/main_title.dart';

class MainTitlecard extends StatelessWidget {
  const MainTitlecard({
    super.key,
    required this.title,
    required this.posterList,
  });
  final String title;
  final List<String> posterList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(title: title),
        KHeight,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              posterList.length,
              (index) => MainCard(
                imageUrl: posterList[index],
              ),
            ),
          ),
        )
      ],
    );
  }
}
