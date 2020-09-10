import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_constants/decorations.dart';
import 'package:my_simple_podcast_app/global_models/podcast_show.dart';

class OtherShowInformation extends StatelessWidget {
  const OtherShowInformation({Key key, @required this.podcastShow})
      : super(key: key);
  final PodcastShow podcastShow;
  Widget build(BuildContext context) {
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
