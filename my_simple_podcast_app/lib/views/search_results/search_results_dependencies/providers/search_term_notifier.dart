import 'package:flutter/foundation.dart';

class SearchTermNotifier extends ChangeNotifier {
  String _searchTerm;
  String get searchTerm {
    return _searchTerm;
  }

  void setSearchTerm(String searchTerm) {
    if (searchTerm != null && searchTerm != _searchTerm) {
      this._searchTerm = searchTerm;
      notifyListeners();
    }
  }
}
