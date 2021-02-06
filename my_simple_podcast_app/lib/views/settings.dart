import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/services/user_settings.dart';

class UserSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text('Settings')),
      ),
      body: ListView(
        children: [
          DisplayTTPToggleButton(),
        ],
      ),
    );
  }
}

class DisplayTTPToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<bool>(
      stream: UserSettings().displayTodaysTopPodcastStream,
      builder: (builder, snapshot) {
        if (snapshot.hasData) {
          return SwitchListTile(
            secondary: Icon(Icons.leaderboard),
            title: const Text('Show Top Podcasts?'),
            value: snapshot.data,
            onChanged: UserSettings().toggleShowTodaysTopPodcasts,
          );
        } else if (snapshot.hasError) {
          return Text("Sorry we had trouble getting your settings");
        } else {
          return LinearProgressIndicator();
        }
      },
    ));
  }
}
