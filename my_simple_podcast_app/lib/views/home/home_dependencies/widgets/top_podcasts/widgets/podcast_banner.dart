import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_components/favorite_icon_button/favorite_icon_button.dart';
import 'package:my_simple_podcast_app/global_models/podcast.dart';
import 'package:provider/provider.dart';

class PodcastBanner extends StatefulWidget {
  const PodcastBanner({
    Key key,
    @required this.podcastShow,
    @required this.maxHeight,
  }) : super(key: key);
  final Podcast podcastShow;
  final double maxHeight;

  @override
  _PodcastBannerState createState() => _PodcastBannerState();
}

class _PodcastBannerState extends State<PodcastBanner> {
  double _popUpHeight;
  Podcast _podcastShow;
  @override
  void initState() {
    super.initState();
    _popUpHeight = widget.maxHeight * .75;
    _podcastShow = widget.podcastShow;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: widget.maxHeight, maxWidth: widget.maxHeight),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            background(context),
            ChangeNotifierProvider.value(
              value: _podcastShow,
              builder: (context, child) {
                return Selector<Podcast, bool>(
                  selector: (_, podcastShow) => podcastShow.hasFocus,
                  builder: (context, hasFocus, child) {
                    return Column(
                      children: [
                        Expanded(
                          child: Image.network(_podcastShow.imageUrl),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          height: hasFocus ? _popUpHeight * .50 : 0,
                          width: double.infinity,
                          child: moreInformation(context),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget moreInformation(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _podcastShow.podcastName,
          style: _themeData.primaryTextTheme.headline6,
        ),
        Text(
          _podcastShow.artistName,
          style: _themeData.primaryTextTheme.bodyText1,
        ),
        FavoriteIconButton(podcastShow: _podcastShow)
      ],
    );
  }

  Widget background(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: _popUpHeight,
        width: widget.maxHeight,
        decoration: BoxDecoration(
            color: themeData.accentColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [themeData.primaryColor, themeData.accentColor])),
      ),
    );
  }
}
