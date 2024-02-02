import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netflix_app/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/colors/constants.dart';
import 'package:netflix_app/domain/downloads/models/download.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VedioListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;

  const VedioListItemInheritedWidget(
      {super.key, required this.widget, required this.movieData})
      : super(child: widget);
  @override
  bool updateShouldNotify(covariant VedioListItemInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VedioListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VedioListItemInheritedWidget>();
  }
}

class VedioListItem extends StatelessWidget {
  final int index;
  const VedioListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VedioListItemInheritedWidget.of(context)?.movieData.posterPath;
    final videoUrl = dummyVideoUrls[index % dummyVideoUrls.length];
    return Stack(
      children: [
        FastLaughVideoPlayer(videoUrl: videoUrl, onStateChanged: (bool) {}),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //left side
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.volume_off,
                        color: KWhiteColor,
                        size: 30,
                      )),
                ),
                //right side
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: posterPath == null
                            ? null
                            : NetworkImage('$imageAppendUrl$posterPath'),
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable: likedVideosIdsNotifier,
                        builder: (BuildContext context,
                            Set<int> newLikedListIds, Widget? _) {
                          final _index = index;
                          bool isLiked = newLikedListIds.contains(_index);

                          if (newLikedListIds.contains(_index)) {
                            return GestureDetector(
                              onTap: () {
                                // BlocProvider.of<FastLaughBloc>(context)
                                //.add(UnlikeVideo(id: _index));
                                likedVideosIdsNotifier.value.remove(_index);
                                likedVideosIdsNotifier.notifyListeners();
                              },
                              child: const VideoActionsWidget(
                                icon: Icons.favorite_outline,
                                title: 'Liked',
                              ),
                            );
                          }
                          return GestureDetector(
                            onTap: () {
                              likedVideosIdsNotifier.value.add(_index);
                              likedVideosIdsNotifier.notifyListeners();

                              //BlocProvider.of<FastLaughBloc>(context)
                              // .add(LikeVideo(id: _index));
                            },
                            child: const VideoActionsWidget(
                                icon: Icons.emoji_emotions, title: 'Lol'),
                          );
                        }),
                    const VideoActionsWidget(icon: Icons.add, title: 'My List'),
                    GestureDetector(
                        onTap: () {
                          final movieName =
                              VedioListItemInheritedWidget.of(context)
                                  ?.movieData
                                  .posterPath;

                          if (movieName != null) {
                            Share.share(movieName);
                          }
                        },
                        child: const VideoActionsWidget(
                            icon: Icons.share, title: 'Share')),
                    const VideoActionsWidget(
                        icon: Icons.play_arrow, title: 'Play')
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class VideoActionsWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const VideoActionsWidget(
      {super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Column(
        children: [
          Icon(
            icon,
            color: KWhiteColor,
            size: 30,
          ),
          Text(
            title,
            style: const TextStyle(color: KWhiteColor, fontSize: 16),
          )
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onStateChanged;
  const FastLaughVideoPlayer(
      {super.key, required this.videoUrl, required this.onStateChanged});

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((value) {
      setState(() {});
      _videoPlayerController.play();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )
          : const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
