import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_services/favorite_podcasts/favorites_podcasts_service.dart';
import 'package:my_simple_podcast_app/global_utils/size_config.dart';
import 'package:provider/provider.dart';

import 'app_bottom_navigation_bar_dependencies/models/tab_meta_data.dart';

class AppSkeletonWithBar extends StatefulWidget {
  AppSkeletonWithBar({Key key}) : super(key: key);
  final FavoritePodcastsService _favoritePodcastsService =
      FavoritePodcastsService();
  @override
  _AppSkeletonWithBarState createState() => _AppSkeletonWithBarState();
}

class _AppSkeletonWithBarState extends State<AppSkeletonWithBar> {
  int _currentIndex = 0;
  List<BottomNavigationBarItem> _icons;
  List<Widget> _screens;
  @override
  void initState() {
    super.initState();
    _icons = <BottomNavigationBarItem>[];
    _screens = <Widget>[];
    feed.forEach((key, value) {
      _icons.add(key);
      _screens.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Container(
      height: SizeConfig.screenHeight,
      color: themeData.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          body: ChangeNotifierProvider.value(
            value: widget._favoritePodcastsService,
            builder: (context, child) {
              return IndexedStack(
                index: _currentIndex,
                children: _screens,
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: _onTabBehavior,
            items: _icons,
          ),
        ),
      ),
    );
  }

  void _onTabBehavior(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
    });
  }
}
