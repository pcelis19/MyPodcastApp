import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_components/podcast_show_tile/widgets/cover_art_widget/cover_art_widget.dart';
import 'package:my_simple_podcast_app/global_models/episode.dart';
import 'package:my_simple_podcast_app/global_models/podcast.dart';
import 'package:my_simple_podcast_app/global_services/rss_parser.dart';

class PodcastHomeScreen extends StatelessWidget {
  final Podcast podcast;

  const PodcastHomeScreen({Key key, this.podcast}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CoverArt(
              imageUrl: podcast.imageUrl,
            ),
          ),
          title: Text(podcast.podcastName),
          centerTitle: true,
        ),
        body: FutureBuilder<List<Episode>>(
          future: RSSParser().fetchEpisodes(podcast),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Episode episode = snapshot.data[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      elevation: 8,
                      child: ListTile(
                        leading: CoverArt(imageUrl: episode.podcast.imageUrl),
                        title: Text(episode.episodeName),
                        subtitle: episode.episodeDuration != null
                            ? Text(episode.episodeDuration)
                            : Container(),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
