import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/constants/decorations.dart';
import 'package:my_simple_podcast_app/models/partial_podcast_information.dart';

class OtherShowInformation extends StatelessWidget {
  const OtherShowInformation(
      {Key key, @required this.partialPodcastInformation})
      : super(key: key);
  final PartialPodcastInformation partialPodcastInformation;
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(partialPodcastInformation.contentAdvisoryRating),
          genrePills(partialPodcastInformation),
        ],
      ),
    );
  }

  Widget genrePills(PartialPodcastInformation podcastShow) {
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
