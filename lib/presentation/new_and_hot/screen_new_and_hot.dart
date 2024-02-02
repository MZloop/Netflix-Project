import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netflix_app/application/hot_and_new/hotandnew_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/colors/constants.dart';
import 'package:netflix_app/presentation/home/widget/custom_button.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/coming_soon_widget.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/everyones_watching_widget.dart';
import 'package:netflix_app/presentation/widgets/video_widget.dart';
import 'package:netflix_app/presentation/widgets/video_widgetnew.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            title: Text(
              "New & Hot",
              style: GoogleFonts.montserrat(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            actions: [
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
            bottom: TabBar(
                labelColor: kBlackColor,
                unselectedLabelColor: KWhiteColor,
                isScrollable: false,
                labelStyle: const TextStyle(
                    fontSize: 15.3, fontWeight: FontWeight.bold),
                indicator:
                    BoxDecoration(color: KWhiteColor, borderRadius: kRadius30),
                tabs: const [
                  Tab(
                    text: "🍿 Coming Soon",
                  ),
                  Tab(
                    text: "👀 Everyone's Watching",
                  ),
                ]),
          ),
        ),
        body: const TabBarView(children: [
          ComingSoonList(key: Key('coming_soon')),
          EveryoneIsWatchingList(key: Key('everyone_is_watching')),
        ]),
      ),
    );
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HotandnewBloc>(context).add(const LoadDataInComingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotandnewBloc>(context)
            .add(const LoadDataInComingSoon());
      },
      child: BlocBuilder<HotandnewBloc, HotandnewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('Error while loading  coming soon'),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text(' coming soon list is empty'),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                itemCount: state.comingSoonList.length,
                itemBuilder: (BuildContext context, index) {
                  final movie = state.comingSoonList[index];
                  if (movie.id == null) {
                    return const SizedBox();
                  }
                  final _date = DateTime.parse(movie.releaseDate!);
                  final formatteddate =
                      DateFormat.yMMMMd('en_US').format(_date);
                  print(formatteddate);
                  return ComingSoonWidget(
                    id: movie.id.toString(),
                    month: formatteddate
                        .split(' ')
                        .first
                        .substring(0, 3)
                        .toUpperCase(),
                    day: movie.releaseDate!.split('-')[1],
                    posterPath: '$imageAppendUrl${movie.posterPath}',
                    movieName: movie.originalTitle ?? 'No title',
                    description: movie.overview ?? 'No Decription',
                  );
                });
          }
        },
      ),
    );
  }
}

class EveryoneIsWatchingList extends StatelessWidget {
  const EveryoneIsWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HotandnewBloc>(context)
          .add(const LoadDataInEveryoneIsWatchingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotandnewBloc>(context)
            .add(const LoadDataInEveryoneIsWatchingSoon());
      },
      child: BlocBuilder<HotandnewBloc, HotandnewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('Error while loading  coming soon'),
            );
          } else if (state.EveryOneWathingList.isEmpty) {
            return const Center(
              child: Text(' EveryOneWathing list is empty'),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: state.EveryOneWathingList.length,
                itemBuilder: (BuildContext context, index) {
                  final tv = state.EveryOneWathingList[index];
                  return EveryonesWatchingWidget(
                    posterPath: '$imageAppendUrl${tv.posterPath}',
                    movieName: tv.originalName ?? 'No name Provided',
                    description: tv.overview ?? 'No description',
                  );
                });
          }
        },
      ),
    );
  }
}
