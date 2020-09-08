import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/util/validators.dart';
import 'package:my_simple_podcast_app/views/search_results/search_results_dependencies/providers/search_term_notifier.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isValidSearchTerm = false;
  bool _autoValidate = false;
  SearchTermNotifier searchTermNotifier;
  @override
  Widget build(BuildContext context) {
    searchTermNotifier = Provider.of<SearchTermNotifier>(context);
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
              onPressed: () =>
                  _tryToSubmitSearchTerm(_textEditingController.text),
            ),
            title: TextFormField(
              controller: _textEditingController,
              onFieldSubmitted: _tryToSubmitSearchTerm,
              validator: _validateSearchTerm,
              onChanged: _startValidatingText,
              autovalidate: _autoValidate,
            ),
          ),
        ),
      ),
    );
  }

  void _tryToSubmitSearchTerm(String value) {
    if (_isValidSearchTerm)
      searchTermNotifier.setSearchTerm(_textEditingController.text);
  }

  void _startValidatingText(value) {
    if (!_autoValidate && mounted) {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  String _validateSearchTerm(value) {
    if (value == null) {
      _isValidSearchTerm = false;
      return null;
    } else {
      if (value.isNotEmpty) {
        if (!Validators.isAlphaNumerical(value)) {
          _isValidSearchTerm = false;
          return "Letters and numbers only, please.";
        } else {
          _isValidSearchTerm = true;
          return null;
        }
      } else {
        _isValidSearchTerm = false;
        return null;
      }
    }
  }
}
