import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:my_simple_podcast_app/utils/validators.dart';

class SearchTermProvider extends ChangeNotifier {
  TextEditingController searchTextEditingController = TextEditingController();
  bool isValidSearchTerm = false;
  String searchTerm;
  String validateSearchTerm(String value) {
    if (value == null) {
      isValidSearchTerm = false;
      return null;
    } else {
      if (value.isNotEmpty) {
        if (!Validators.isAlphaNumerical(value)) {
          isValidSearchTerm = false;
          return "Letters and numbers only, please.";
        } else {
          isValidSearchTerm = true;
          return null;
        }
      } else {
        isValidSearchTerm = false;
        return null;
      }
    }
  }

  void quickPreviousSearchTerm(String value) {
    validateSearchTerm(value);
    if (isValidSearchTerm) {
      searchTextEditingController.text = value;
      searchTerm = value;
      notifyListeners();
    }
  }

  void keyboardSubmitSearchTerm(String value) {
    if (isValidSearchTerm) {
      searchTerm = value;
      notifyListeners();
    }
  }

  void iconPressSearchTerm() {
    String value = searchTextEditingController.text;
    if (isValidSearchTerm) {
      searchTerm = value;
      notifyListeners();
    }
  }

  void textChangeBehavior(String value) {
    if (value == null || value.isEmpty) {
      searchTerm = null;
      notifyListeners();
    }
  }

  void clearSearchScreen() {
    searchTerm = "";
    searchTextEditingController.text = searchTerm;

    notifyListeners();
  }
}
