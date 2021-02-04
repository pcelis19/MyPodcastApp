import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_components/favorite_icon_button/favorite_icon_button.dart';
import 'package:my_simple_podcast_app/global_models/partial_podcast_information.dart';

class PodcastBanner extends StatefulWidget {
  const PodcastBanner({
    Key key,
    @required this.podcastShow,
    @required this.maxHeight,
  }) : super(key: key);
  final PartialPodcastInformation podcastShow;
  final double maxHeight;

  @override
  _PodcastBannerState createState() => _PodcastBannerState(
        popUpHeight: maxHeight,
        podcastShow: podcastShow,
      );
}

class _PodcastBannerState extends State<PodcastBanner> {
  final double popUpHeight;
  final PartialPodcastInformation podcastShow;

  _PodcastBannerState({
    @required this.popUpHeight,
    @required this.podcastShow,
  });
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: widget.maxHeight, maxWidth: widget.maxHeight),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            background(context),
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Image.network(podcastShow.imageUrl),
                    ),
                  ),
                ),
                spliter(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        podcastShow.podcastName,
                        style: _themeData.primaryTextTheme.headline6,
                      ),
                      Text(
                        podcastShow.artistName,
                        style: _themeData.primaryTextTheme.bodyText1,
                      ),
                      FavoriteIconButton(
                        partialPodcastInformation: podcastShow,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget background(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: popUpHeight,
        width: widget.maxHeight,
        decoration: BoxDecoration(
          color: themeData.accentColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [themeData.primaryColor, themeData.accentColor],
          ),
        ),
      ),
    );
  }

  Widget spliter() {
    return Center(
      child: Container(
        width: 48,
        height: 1,
        color: Colors.white,
      ),
    );
  }
}
