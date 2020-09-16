import 'package:flutter/material.dart';

import 'home_dependencies/widgets/favorite_podcasts.dart';
import 'home_dependencies/widgets/top_podcasts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  /** General Layout
     * Coursel top shows
     * * Display names
     * * Display country <- that'll be cool
     * Favorites
     * * fetch favorites from cached FUTURE <-Fetch from firebase after signin/signup is done 
     * 
     * 
     */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [TopPodcasts(), FavoritePodcasts()],
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
