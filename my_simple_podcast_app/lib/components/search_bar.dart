import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/providers/search_term_provider.dart';
import 'package:provider/provider.dart';

import 'search_results.dart';

class SearchBar extends StatefulWidget with PreferredSizeWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return Size.fromHeight(100);
  }
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    return Consumer<SearchTermProvider>(
      builder: (context, searchTermProvider, child) {
        return Container(
          color: _themeData.primaryColor,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                    color: _themeData.primaryIconTheme.color,
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      // TODO implement function
                      Scaffold.of(context).openDrawer();
                    }),
              ),
              Expanded(
                flex: 7,
                child: Card(
                  elevation: 18,
                  child: ListTile(
                    title: TextFormField(
                      controller:
                          searchTermProvider.searchTextEditingController,
                      onFieldSubmitted: (String searchTerm) {
                        searchTermProvider.keyboardSubmitSearchTerm(searchTerm);
                        if (searchTermProvider.isValidSearchTerm) {
                          showBottomSheet(
                            context: context,
                            builder: (context) => SearchResults(),
                          );
                        }
                      },
                      onChanged: searchTermProvider.textChangeBehavior,
                      validator: searchTermProvider.validateSearchTerm,
                      autovalidate: true,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        searchTermProvider.iconPressSearchTerm();
                        if (searchTermProvider.isValidSearchTerm) {
                          showBottomSheet(
                            context: context,
                            builder: (context) => SearchResults(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
