import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_utils/size_config.dart';
import 'package:provider/provider.dart';

import 'search_dependencies/providers/search_term_provider.dart';
import 'search_dependencies/widgets/search_bar/search_bar.dart';
import 'search_dependencies/widgets/search_results/search_results.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key key,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin {
  SearchTermProvider _searchTermNotifier = SearchTermProvider();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig().init(context);
    return ChangeNotifierProvider<SearchTermProvider>.value(
      value: _searchTermNotifier,
      builder: (context, child) {
        return Container(
          color: themeData.backgroundColor,
          height: SizeConfig.screenHeight,
          child: Scaffold(
            body: Column(
              children: [
                SearchBar(),
                SearchResults(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
