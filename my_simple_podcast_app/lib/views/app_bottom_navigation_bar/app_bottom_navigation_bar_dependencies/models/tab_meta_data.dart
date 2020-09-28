import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/views/home/home_screen.dart';
import 'package:my_simple_podcast_app/views/search/search_screen.dart';

const Map<BottomNavigationBarItem, Widget> feed = {
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    title: Text('Home'),
  ): HomePage(),
  BottomNavigationBarItem(
    icon: Icon(Icons.search),
    title: Text('Search'),
  ): SearchScreen(),
};
