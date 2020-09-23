import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/views/app_bottom_navigation_bar/app_bottom_navigation_bar.dart';

import 'global_services/favorite_podcasts/favorites_podcasts_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavoritePodcastsService().intializeFavorites();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      theme: ThemeData(
          primarySwatch: Colors.indigo, accentColor: Colors.redAccent),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBottomNavigationBar();
  }
}
