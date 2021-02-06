import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/constants/route_names.dart';
import 'package:my_simple_podcast_app/models/episode.dart';
import 'package:my_simple_podcast_app/models/full_podcast_information.dart';
import 'package:my_simple_podcast_app/models/partial_podcast_information.dart';
import 'package:my_simple_podcast_app/services/audio_player/audio_player.dart';
import 'package:my_simple_podcast_app/utils/rss_parser.dart' as rssParser;
import 'package:my_simple_podcast_app/widgets/cover_art_widget.dart';
import 'package:my_simple_podcast_app/widgets/favorite_icon_button.dart';

/// returns the list of episodes for a given podacst
class ListOfEpisodes extends StatelessWidget {
  const ListOfEpisodes({
    Key key,
    @required this.partialPodcastInformation,
  }) : super(key: key);

  final PartialPodcastInformation partialPodcastInformation;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FullPodcastInformation>(
      future: compute(rssParser.fetchEpisodes, partialPodcastInformation),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data.podcastEpisodes.isEmpty) {
          /// if in the off chance there are no episodes
          /// from a given podcast, then tell the user there isn't
          /// any episodes to display
          return Center(
            child: AlertDialog(
              title: Text("Whaat!"),
              elevation: 8,
              content: Text("There seems to be no episodes!?"),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Ok..."),
                )
              ],
            ),
          );
        } else {
          return Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SingleChildScrollView(
                          child: Text(snapshot.data.description)),
                    ),
                    Expanded(
                      child: FavoriteIconButton(
                          partialPodcastInformation: partialPodcastInformation),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.podcastEpisodes.length,
                  itemBuilder: (context, index) {
                    Episode episode = snapshot.data.podcastEpisodes[index];
                    return Card(
                      elevation: 4,
                      child: ListTile(
                        onTap: () async {
                          await AudioPlayer().playNextEpisode(episode);

                          Navigator.of(context).pushNamed(kAudioPlayerView);
                        },
                        leading: CoverArt(
                            imageUrl:
                                episode.partialPodcastInformation.imageUrl),
                        title: Text(episode.episodeName),
                        subtitle: episode.episodeDuration != null
                            ? Text(episode.episodeDuration)
                            : Container(),
                        contentPadding: EdgeInsets.all(8),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
