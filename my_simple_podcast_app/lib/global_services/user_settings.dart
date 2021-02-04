import 'dart:async';
import 'dart:developer';

import 'package:rxdart/subjects.dart';

class UserSettings {
  static UserSettings _userSettings = UserSettings.internal();
  UserSettings.internal();
  factory UserSettings() {
    return _userSettings;
  }
  final StreamController<bool> _controller = BehaviorSubject<bool>();
  bool _hasBeenInitialized = false;
  bool _displayTTP;
  Stream _broadcastStream;
  Future<void> initializeUserSettings() {
    if (!_hasBeenInitialized) {
      _hasBeenInitialized = true;
      _broadcastStream = _controller.stream;
      _connectInternalBoolean();
      _controller.sink.add(true);
    }
    return Future.value();
  }

  void _connectInternalBoolean() {
    _broadcastStream.listen((event) {
      _displayTTP = event;
      log('[SWTICH] $event');
    });
  }

  void toggleShowTodaysTopPodcasts(bool value) {
    _controller.sink.add(value);
  }

  Stream<bool> get displayTodaysTopPodcastStream {
    initializeUserSettings();
    return _broadcastStream.asBroadcastStream();
  }
}
