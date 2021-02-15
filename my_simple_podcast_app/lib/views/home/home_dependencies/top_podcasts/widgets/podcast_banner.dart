import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_components/favorite_icon_button/favorite_icon_button.dart';
import 'package:my_simple_podcast_app/global_models/partial_podcast_information.dart';
import 'package:my_simple_podcast_app/global_constants/route_names.dart';

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
        child: FlatButton(
          onPressed: () => Navigator.of(context)
              .pushNamed(kPodcastHomeView, arguments: podcastShow),
          child: Stack(
            children: [
              background(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Center(
                        child: Hero(
                          tag: podcastShow.imageUrl,
                          child: Image.network(podcastShow.imageUrl),
                        ),
                      ),
                    ),
                    Expanded(child: spliter()),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            
                            podcastShow.podcastName,
                            style: _themeData.primaryTextTheme.headline6,maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            minFontSize: _themeData.primaryTextTheme.headline6.fontSize,
                          ),
                          AutoSizeText(
                            podcastShow.artistName,
                            style: _themeData.primaryTextTheme.bodyText1,
                            overflow: TextOverflow.ellipsis,
                            minFontSize: _themeData.primaryTextTheme.bodyText1.fontSize,
                          ),
                          FavoriteIconButton(
                            partialPodcastInformation: podcastShow,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget background(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
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
