import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_components/favorite_icon_button/favorite_icon_button.dart';
import 'package:my_simple_podcast_app/global_components/pill_button.dart';
import 'package:my_simple_podcast_app/global_components/podcast_show_tile/podcast_show_tile.dart';
import 'package:my_simple_podcast_app/global_components/podcast_show_tile/widgets/cover_art_widget/cover_art_widget.dart';
import 'package:my_simple_podcast_app/global_models/podcast.dart';
import 'package:my_simple_podcast_app/global_services/podcast_search/podcast_search_service.dart';
import 'package:my_simple_podcast_app/global_utils/route_names.dart';
import 'package:my_simple_podcast_app/views/podcast_home_screen/podcast_home_screen.dart';
import 'package:my_simple_podcast_app/views/search/search_dependencies/providers/search_term_provider.dart';

import 'package:provider/provider.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({
    Key key,
  }) : super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

// TODO fix search bug, why is it not responding to change notifier
class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchTermProvider>(
        builder: (context, searchTermProivder, child) {
      return Expanded(
        child: searchTermProivder.searchTerm == null ||
                searchTermProivder.searchTerm.isEmpty
            ? previousSearchTerms(searchTermProivder)
            : searchResults(searchTermProivder.searchTerm),
      );
    });
  }

  FutureBuilder previousSearchTerms(SearchTermProvider searchTermProvider) {
    return FutureBuilder<List<dynamic>>(
      future: PodcastSearchService().previousSearchTerms,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return Center(
              child: Column(
                children: [
                  Icon(Icons.history),
                  Text('No search history :('),
                ],
              ),
            );
          } else {
            List<Widget> searchTerms = [];
            for (dynamic term in snapshot.data) {
              searchTerms.add(
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: PillButton(
                    function: () => searchTermProvider
                        .quickPreviousSearchTerm(term.toString()),
                    label: term,
                  ),
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Wrap(
                children: searchTerms,
              ),
            );
          }
        } else {
          return Center(
            child: Column(
              children: [
                Icon(Icons.history),
                Text('No search history :('),
              ],
            ),
          );
        }
      },
    );
  }

  FutureBuilder searchResults(String searchTerm) {
    log('previousSearchTerms');

    return FutureBuilder<List<Podcast>>(
      future: PodcastSearchService().searchTerm(searchTerm),
      builder: (BuildContext context, AsyncSnapshot<List<Podcast>> snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Podcast podcast = snapshot.data[index];
                  return Card(
                    elevation: 8,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        onTap: () => Navigator.pushNamed(
                            context, kPodcastHomeScreen,
                            arguments: podcast),
                        leading: CoverArt(imageUrl: podcast.imageUrl),
                        title: Text(podcast.podcastName),
                        subtitle: Text(podcast.artistName),
                        trailing: FavoriteIconButton(
                          podcast: podcast,
                        ),
                      ),
                    ),
                  );
                }),
          );
        } else {
          return Center(child: Text("Waiting..."));
        }
      },
    );
  }
}
