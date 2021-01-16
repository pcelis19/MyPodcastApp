import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_components/favorite_icon_button/favorite_icon_button.dart';
import 'package:my_simple_podcast_app/global_components/podcast_show_tile/widgets/cover_art_widget/cover_art_widget.dart';
import 'package:my_simple_podcast_app/global_models/episode.dart';
import 'package:my_simple_podcast_app/global_models/full_podcast_information.dart';
import 'package:my_simple_podcast_app/global_models/partial_podcast_information.dart';
import 'package:my_simple_podcast_app/global_services/audio_player/audio_player.dart';
import 'package:my_simple_podcast_app/global_services/rss_parser.dart';

class PodcastEpisodes extends StatelessWidget {
  const PodcastEpisodes({
    Key key,
    @required this.partialPodcastInformation,
  }) : super(key: key);

  final PartialPodcastInformation partialPodcastInformation;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FullPodcastInformation>(
      future: RSSParser().fetchEpisodes(partialPodcastInformation),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
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
                        onTap: () => AudioPlayer().playNextEpisode(episode),
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
