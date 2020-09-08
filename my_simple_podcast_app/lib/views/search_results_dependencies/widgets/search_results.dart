import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/components/podcast_show_tile.dart';
import 'package:my_simple_podcast_app/models/podcast_show.dart';
import 'package:my_simple_podcast_app/services/podcast_search_service.dart';
import 'package:my_simple_podcast_app/views/search_results_dependencies/providers/search_term_notifier.dart';
import 'package:provider/provider.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({
    Key key,
  }) : super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchTermNotifier>(
        builder: (context, searchTermProivder, child) {
      return Expanded(
        child: searchTermProivder.searchTerm == null ||
                searchTermProivder.searchTerm.isEmpty
            ? previousSearchTerms(searchTermProivder.searchTerm)
            : searchResults(searchTermProivder.searchTerm),
      );
    });
  }

  FutureBuilder<List<String>> previousSearchTerms(String deleteBecauseTesting) {
    log('previousSearchTerms [$deleteBecauseTesting]');
    return FutureBuilder<List<String>>(
      future: PodcastSearchService().previousSearchTerms,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
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
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Chip(
                    label: Text(
                      snapshot.data[index],
                    ),
                  );
                }),
          );
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

  FutureBuilder<List<PodcastShow>> searchResults(String searchTerm) {
    log('previousSearchTerms');

    return FutureBuilder<List<PodcastShow>>(
      future: PodcastSearchService().searchTerm(searchTerm),
      builder:
          (BuildContext context, AsyncSnapshot<List<PodcastShow>> snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
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
    );
  }
}
