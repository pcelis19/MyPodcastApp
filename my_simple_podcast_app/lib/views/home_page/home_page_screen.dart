import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Center(
      child: Container(
        child: Text('NO HOME PAGE :('),
      ),
    );
  }
}
