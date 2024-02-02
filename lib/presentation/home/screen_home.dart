import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/homeblock/home_bloc.dart';

import 'package:netflix_app/core/colors/constants.dart';
import 'package:netflix_app/presentation/home/widget/background_card.dart';
import 'package:netflix_app/presentation/home/widget/custom_button.dart';
import 'package:netflix_app/presentation/home/widget/number_title.dart';

import 'package:netflix_app/presentation/widgets/main_title_card.dart';

ValueNotifier<bool> ScrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: ScrollNotifier,
        builder: (BuildContext context, index, _) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              if (direction == ScrollDirection.reverse) {
                ScrollNotifier.value = false;
              } else if (direction == ScrollDirection.forward) {
                ScrollNotifier.value = true;
              }

              return true;
            },
            child: Stack(
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ));
                    } else if (state.hasError) {
                      return const Center(
                        child: Text(
                          "Error While getting Data",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    //realeashed pat year
                    final _realeashedPastYear =
                        state.pastYearMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    //trending
                    final _trending = state.trendingMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    //tense dramas

                    final _tensedramas = state.tensedramasMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();

                    //South indian Cinema
                    final _southIndianCinema =
                        state.southIndianMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    _southIndianCinema.shuffle();
                    //top10tvshows
                    final _top10Tvshows = state.trendingMovieList.map((t) {
                      return '$imageAppendUrl${t.posterPath}';
                    }).toList();
                    _top10Tvshows.shuffle();
                    final _bigimage = state.trendingMovieList.map((b) {
                      return '$imageAppendUrl${b.posterPath}';
                    }).toList();
                    return ListView(
                      children: [
                        backbig_home(
                          postersList: _bigimage,
                        ),
                        MainTitlecard(
                          title: "Realeashed in the Past Year",
                          posterList: _realeashedPastYear,
                        ),
                        KHeight,
                        MainTitlecard(
                          title: "Trending Now",
                          posterList: _trending,
                        ),
                        KHeight,
                        NumberTitleCard(
                            postersList: _top10Tvshows.sublist(0, 10)),
                        KHeight,
                        MainTitlecard(
                          title: "Tense Dramas",
                          posterList: _tensedramas,
                        ),
                        KHeight,
                        MainTitlecard(
                          title: "South Indian Cinema",
                          posterList: _southIndianCinema,
                        ),
                        KHeight
                      ],
                    );
                  },
                ),
                ScrollNotifier.value == true
                    ? AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: double.infinity,
                        height: 80,
                        color: Colors.black.withOpacity(0.8),
                        child: Column(
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Image.network(
                                  "https://images.ctfassets.net/4cd45et68cgf/Rx83JoRDMkYNlMC9MKzcB/2b14d5a59fc3937afd3f03191e19502d/Netflix-Symbol.png",
                                  width: 50,
                                  height: 50,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.cast,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                KWidth,
                                Container(
                                  width: 30,
                                  height: 30,
                                  color: Colors.blue,
                                ),
                                KWidth
                              ],
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "TV Shows",
                                  style: khometitleTextStyle,
                                ),
                                Text(
                                  "Movies",
                                  style: khometitleTextStyle,
                                ),
                                Text(
                                  "Categories",
                                  style: khometitleTextStyle,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : KHeight
              ],
            ),
          );
        },
      ),
    );
  }
}

class backbig_home extends StatelessWidget {
  const backbig_home({
    super.key,
    required this.postersList,
  });
  final List<String> postersList;

  @override
  Widget build(BuildContext context) {
    final String backgroundImageUrl =
        postersList.isNotEmpty ? postersList[5] : '';
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 600,
        decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(backgroundImageUrl))),
      ),
      const Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                icon: Icons.add,
                title: "My List",
              ),
              PlayButton(),
              CustomButton(icon: Icons.info, title: "Info")
            ],
          ),
        ),
      )
    ]);
  }
}
