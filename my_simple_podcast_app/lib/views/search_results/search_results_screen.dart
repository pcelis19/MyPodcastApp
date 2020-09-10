import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_utils/size_config.dart';
import 'package:my_simple_podcast_app/views/search_results/search_results_dependencies/providers/search_term_notifier.dart';
import 'package:my_simple_podcast_app/views/search_results/search_results_dependencies/widgets/search_bar.dart';
import 'package:my_simple_podcast_app/views/search_results/search_results_dependencies/widgets/search_results.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig().init(context);
    return ChangeNotifierProvider<SearchTermNotifier>.value(
      value: SearchTermNotifier(),
      child: Container(
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
      ),
    );
  }
}
