import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/views/home_page/home_page_screen.dart';
import 'package:my_simple_podcast_app/views/search_results/search_results_screen.dart';
import 'package:tuple/tuple.dart';

const List<Tuple2<BottomNavigationBarItem, Widget>> _feed = [
  Tuple2(
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
    ),
    HomePage(),
  ),
  Tuple2(
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      title: Text('Show Search'),
    ),
    SearchScreen(),
  )
];

class TabMetaData {
  List<BottomNavigationBarItem> icons;
  List<Widget> screens;
  TabMetaData() {
    screens = [];
    icons = [];
    for (Tuple2<BottomNavigationBarItem, Widget> item in _feed) {
      icons.add(item.item1);
      screens.add(item.item2);
    }
  }
}
