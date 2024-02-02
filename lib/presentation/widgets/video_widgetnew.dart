import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/colors/constants.dart';

class videoWidgetNew extends StatelessWidget {
  final String url;
  const videoWidgetNew({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 210,
          child: Image.network(
            url,
            fit: BoxFit.cover,
            loadingBuilder:
                (BuildContext _, Widget child, ImageChunkEvent? progress) {
              if (progress == null) {
                return child;
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                ));
              }
            },
            errorBuilder: (BuildContext _, Object a, StackTrace? trace) {
              return const Center(
                child: Icon(
                  Icons.wifi,
                  color: Colors.grey,
                  size: 6,
                ),
              );
            },
          ),
        ),
        Positioned(
          right: 8,
          bottom: 2,
          child: CircleAvatar(
            radius: 23,
            backgroundColor: Colors.black.withOpacity(0.5),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.volume_off,
                color: KWhiteColor,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
