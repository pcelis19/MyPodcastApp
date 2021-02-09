import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/constants/decorations.dart';
import 'package:my_simple_podcast_app/constants/route_names.dart';
import 'package:my_simple_podcast_app/models/partial_podcast_information.dart';
import 'package:my_simple_podcast_app/utils/size_config.dart';
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
    double height = SizeConfig.screenHeight * kBannerPercentHeight;
    double width = double.infinity;
    return Container(
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: FlatButton(
          onPressed: () => Navigator.of(context)
              .pushNamed(kPodcastHomeView, arguments: podcastShow),
          child: Stack(
            children: [
              background(context),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Center(
                        child: Hero(
                          tag: podcastShow.imageUrl,
                          child: Image.network(podcastShow.imageUrl),
                        ),
                      ),
                    ),
                    Expanded(
                      child: spliter(),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            podcastShow.podcastName,
                            style: _themeData.primaryTextTheme.headline6,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            podcastShow.artistName,
                            style: _themeData.primaryTextTheme.bodyText1,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                          Spacer(),
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
