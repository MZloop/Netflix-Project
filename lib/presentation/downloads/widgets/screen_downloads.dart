import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/downloads/downloads_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/colors/constants.dart';
import 'package:netflix_app/presentation/widgets/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({super.key});
  final _widgetList = [const _smartDownloads(), Section2(), Section3()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarWidget(
            title: "Downloads",
          )),
      body: ListView.separated(
        padding: EdgeInsets.all(10),
        itemBuilder: (ctx, index) => _widgetList[index],
        separatorBuilder: (ctx, index) => SizedBox(
          height: 27,
        ),
        itemCount: _widgetList.length,
      ),
    );
  }
}

class Section2 extends StatelessWidget {
  Section2({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(DownloadsEvent.getDownloadsImages());
    });
    // BlocProvider.of<DownloadsBloc>(context)
    //     .add(const DownloadsEvent.getDownloadsImages());
    return Column(
      children: [
        const Text(
          "Introducing Downloads For You",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: KWhiteColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        KHeight,
        const Text(
          "We'll download a persionalised selection of \nmovies and shows for you,so there's \n always something to watch on your \ndevice.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) {
            return SizedBox(
              width: size.width,
              height: size.width,
              child: state.isloading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.grey,
                    ))
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.5),
                          radius: size.width * 0.4,
                        ),
                        downloadsImageWidget(
                          imageList:
                              '$imageAppendUrl${state.downloads?[19].posterPath}',
                          margin:
                              EdgeInsets.only(left: 150, bottom: 0, top: 20),
                          angle: 25,
                          size: Size(size.width * 0.57, size.width * 0.57),
                        ),
                        downloadsImageWidget(
                          imageList:
                              '$imageAppendUrl${state.downloads?[1].posterPath}',
                          margin:
                              EdgeInsets.only(right: 150, bottom: 0, top: 20),
                          angle: -25,
                          size: Size(size.width * 0.57, size.width * 0.57),
                        ),
                        downloadsImageWidget(
                          imageList:
                              '$imageAppendUrl${state.downloads?[2].posterPath}',
                          radius: 10,
                          margin: EdgeInsets.only(bottom: 10, top: 20),
                          size: Size(size.width * 0.67, size.width * 0.65),
                        ),
                      ],
                    ),
            );
          },
        ),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            color: KButttoncolorBlue,
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(6)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Set Up",
                style: TextStyle(
                    color: KWhiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        KHeight,
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            color: KButtonColorWhite,
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(6)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "See What You Can Download",
                style: TextStyle(
                    color: kBlackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _smartDownloads extends StatelessWidget {
  const _smartDownloads({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        KWidth,
        Icon(
          Icons.settings,
          color: KWhiteColor,
        ),
        KWidth,
        Text("Smart Downloads")
      ],
    );
  }
}

class downloadsImageWidget extends StatelessWidget {
  const downloadsImageWidget(
      {super.key,
      required this.imageList,
      this.angle = 0,
      required this.margin,
      required this.size,
      this.radius = 10});

  final String imageList;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: Container(
          //  margin: margin,
          clipBehavior: Clip.hardEdge,
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage(
                imageList,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
