import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/components/podcast_show_tile.dart';
import 'package:my_simple_podcast_app/globals/size_config.dart';
import 'package:my_simple_podcast_app/models/podcast_show.dart';
import 'package:my_simple_podcast_app/services/podcast_search_service.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({Key key, this.searchTerm}) : super(key: key);
  final String searchTerm;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig().init(context);
    return Container(
      color: themeData.backgroundColor,
      child: Scaffold(
        body: SafeArea(
            child: FutureBuilder<List<PodcastShow>>(
          future: PodcastSearchService().searchTerm(searchTerm),
          builder: (BuildContext context,
              AsyncSnapshot<List<PodcastShow>> snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return PodcastShowTile(snapshot.data[index]);
                    }),
              );
            } else {
              return Center(child: Text("Waiting..."));
            }
          },
        )),
      ),
    );
  }
}
