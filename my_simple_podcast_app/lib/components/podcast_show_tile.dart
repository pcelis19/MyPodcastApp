import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/constants/decorations.dart';
import 'package:my_simple_podcast_app/globals/size_config.dart';
import 'package:my_simple_podcast_app/models/podcast_show.dart';
import 'package:provider/provider.dart';

class PodcastShowTile extends StatelessWidget {
  const PodcastShowTile(this.podcastShow);
  final PodcastShow podcastShow;
  final double _maxTileSize = .15;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Provider(
      create: (_) => podcastShow,
      child: Container(
        height: SizeConfig.screenHeight * _maxTileSize,
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CoverArt(),
                ),
                Expanded(
                  flex: 4,
                  child: ShowInformation(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowInformation extends StatelessWidget {
  const ShowInformation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ShowTitle(), HostInformation(), OtherShowInformation()],
    );
  }
}

class CoverArt extends StatelessWidget {
  const CoverArt({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PodcastShow podcastShow = Provider.of<PodcastShow>(context);
    final String imageUrl = podcastShow.imageUrl;

    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.network(imageUrl),
      ),
    );
  }
}

class ShowTitle extends StatelessWidget {
  const ShowTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PodcastShow podcastShow = Provider.of<PodcastShow>(context);
    return Expanded(
      child: AutoSizeText(
        podcastShow.showName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class HostInformation extends StatelessWidget {
  const HostInformation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PodcastShow podcastShow = Provider.of<PodcastShow>(context);

    return Expanded(
      child: Text("host: ${podcastShow.artistName}"),
    );
  }
}

class OtherShowInformation extends StatelessWidget {
  const OtherShowInformation({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    final PodcastShow podcastShow = Provider.of<PodcastShow>(context);
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(podcastShow.contentAdvisoryRating),
          genrePills(podcastShow),
        ],
      ),
    );
  }

  Widget genrePills(PodcastShow podcastShow) {
    // think of better implementation
    List<Widget> genrePills = [];
    bool darkGrey = true;
    for (String genre in podcastShow.genres) {
      genrePills.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                genre,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          decoration: kRoundedEdges.copyWith(
              color: darkGrey ? Colors.grey[700] : Colors.grey),
        ),
      );
      // flip switch
      darkGrey = !darkGrey;
    }

    return Expanded(
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: genrePills,
      ),
    );
  }
}
