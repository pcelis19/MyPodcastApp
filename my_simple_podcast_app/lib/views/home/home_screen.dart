import 'package:flutter/material.dart';

import 'home_dependencies/widgets/favorite_podcasts/favorite_podcasts.dart';
import 'home_dependencies/widgets/top_podcasts/top_podcasts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  /** General Layout
     * Coursel top podcasts
     * * Display names
     * * Display country <- that'll be cool
     * Favorites
     * * fetch favorites from cached FUTURE <-Fetch from firebase after signin/signup is done 
     * 
     * 
     */
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
        backgroundColor: themeData.primaryColorLight,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              topPodcastHeader(context),
              TopPodcasts(),
              yourFavoritesHeader(context),
              FavoritePodcasts()
            ],
          ),
        ));
  }

  Widget topPodcastHeader(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Text(
      'Top Podcasts',
      style: themeData.accentTextTheme.headline2,
    );
  }

  Widget yourFavoritesHeader(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Text(
      'Your Favorites',
      style: themeData.accentTextTheme.headline2,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
