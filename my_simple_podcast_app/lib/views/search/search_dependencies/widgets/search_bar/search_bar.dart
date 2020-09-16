import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/views/search/search_dependencies/providers/search_term_provider.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchTermProvider>(
      builder: (context, searchTermProvider, child) {
        return Container(
          margin: EdgeInsets.only(top: 5),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Card(
              elevation: 8,
              child: ListTile(
                autofocus: true,
                trailing: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => searchTermProvider.iconPressSearchTerm,
                ),
                title: TextFormField(
                  controller: searchTermProvider.searchTextEditingController,
                  onFieldSubmitted: searchTermProvider.keyboardSubmitSearchTerm,
                  onChanged: searchTermProvider.textChangeBehavior,
                  validator: searchTermProvider.validateSearchTerm,
                  autovalidate: true,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
