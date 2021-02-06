import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/constants/route_names.dart';
import 'package:my_simple_podcast_app/models/partial_podcast_information.dart';
import 'package:my_simple_podcast_app/widgets/favorite_icon_button.dart';

class PodcastBanner extends StatelessWidget {
  const PodcastBanner({
    Key key,
    @required this.podcastShow,
  }) : super(key: key);
  final PartialPodcastInformation podcastShow;

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    return Expanded(
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
                      flex: 2,
                      child: Center(
                        child: Hero(
                          tag: podcastShow.imageUrl,
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
    log("[COLOR]: \nprimary: ${themeData.primaryColor.toString()}\nsecondary:${themeData.accentColor.toString()} ");
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
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
