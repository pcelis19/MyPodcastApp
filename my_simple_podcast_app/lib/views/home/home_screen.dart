import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_components/audio_player_related/audio_player_widget.dart';
import 'package:my_simple_podcast_app/global_services/user_settings.dart';
import 'package:my_simple_podcast_app/views/home/home_dependencies/search/search_dependencies/providers/search_term_provider.dart';
import 'package:my_simple_podcast_app/views/home/home_dependencies/search/search_dependencies/widgets/search_bar.dart';
import 'package:provider/provider.dart';

import 'home_dependencies/favorite_podcasts/favorite_podcasts.dart';
import 'home_dependencies/top_podcasts/top_podcasts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SearchTermProvider _searchTermProvider = SearchTermProvider();
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
    return ChangeNotifierProvider<SearchTermProvider>.value(
      value: _searchTermProvider,
      builder: (context, child) {
        return Container(
          height: double.infinity,
          color: themeData.backgroundColor,
          child: SafeArea(
            child: WillPopScope(
              onWillPop: () => _onWillPopScope(_searchTermProvider),
              child: Scaffold(
                appBar: SearchBar(),
                drawer: Drawer(
                  child: ListView(
                    children: [
                      DrawerHeader(
                        child: Text(
                          'Simple Podcast Player',
                          style: themeData.textTheme.headline4,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                        onTap: () => Navigator.pushNamed(context, '/settings'),
                      ),
                    ],
                  ),
                ),
                body: Stack(
                  children: [
                    Container(
                      color: themeData.primaryColorLight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            topPodcastHeader(context),
                            TopPodcasts(),
                            yourFavoritesHeader(context),
                            FavoritePodcasts()
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white,
                        child: AudioPlayerWidget(),
                      ),
                    )
                  ],
                ),
                // bottomSheet: AudioPlayerWidget(),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> _onWillPopScope(SearchTermProvider searchTermProvider) async {
    if (searchTermProvider.searchTerm == null ||
        searchTermProvider.searchTerm.isEmpty) {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('Do you want to exit?'),
          actions: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes'),
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
          ],
        ),
      );
    } else {
      searchTermProvider.clearSearchScreen();
      return false;
    }
  }

  Widget topPodcastHeader(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Widget kDefault = Text(
      'Today\'s Top ',
      style: themeData.accentTextTheme.headline2,
    );
    return StreamBuilder<bool>(
        stream: UserSettings().displayTodaysTopPodcastStream,
        builder: (builder, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return kDefault;
            } else {
              return Container();
            }
          } else {
            return kDefault;
          }
        });
  }

  Widget yourFavoritesHeader(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Text(
      'Your Favorites',
      style: themeData.accentTextTheme.headline2,
    );
  }
}
