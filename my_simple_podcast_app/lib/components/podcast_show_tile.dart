import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/constants/decorations.dart';
import 'package:my_simple_podcast_app/globals/size_config.dart';
import 'package:my_simple_podcast_app/models/podcast_show.dart';

class PodcastShowTile extends StatelessWidget {
  const PodcastShowTile(this.podcastShow);
  final PodcastShow podcastShow;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.screenHeight * .20,
      width: SizeConfig.screenWidth,
      child: Row(
        children: [
          CoverArt(imageUrl: podcastShow.imageUrl),
          ShowInformation(podcastShow: podcastShow)
        ],
      ),
    );
  }
}

class ShowInformation extends StatelessWidget {
  const ShowInformation({
    Key key,
    this.podcastShow,
  }) : super(key: key);
  final PodcastShow podcastShow;

  @override
  Widget build(BuildContext context) {
    // this.showName,
    // this.artistName,

    // this.releaseDate,
    // this.contentAdvisoryRating |  this.genres,
    return Container(
      child: Column(
        children: [showTitle(), hostInformation(), showMetaData()],
      ),
    );
  }

  Widget showTitle() {
    return Expanded(
      child: Text(podcastShow.showName),
    );
  }

  Widget hostInformation() {
    return Expanded(
      child: Text("host: ${podcastShow.artistName}"),
    );
  }

  Widget showMetaData() {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(podcastShow.contentAdvisoryRating),
          genrePills(),
        ],
      ),
    );
  }

  Widget genrePills() {
    // think of better implementation
    List<Widget> genrePills = [];
    bool darkGrey = true;
    for (String genre in podcastShow.genres) {
      genrePills.add(
        Container(
          child: Text(
            genre,
            style: TextStyle(color: Colors.white),
          ),
          decoration: kRoundedEdges.copyWith(
              color: darkGrey ? Colors.grey : Colors.grey[700]),
        ),
      );
      // flip switch
      darkGrey = !darkGrey;
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: genrePills,
    );
  }
}

class CoverArt extends StatelessWidget {
  const CoverArt({Key key, this.imageUrl}) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.network(imageUrl),
      ),
    );
  }
}
