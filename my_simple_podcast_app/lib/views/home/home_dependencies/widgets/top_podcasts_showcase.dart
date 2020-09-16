import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/podcast_show.dart';
import 'package:my_simple_podcast_app/global_services/podcast_search_service.dart';

class TopPodcastsShowcase extends StatefulWidget {
  const TopPodcastsShowcase({Key key}) : super(key: key);

  @override
  _TopPodcastsShowcaseState createState() => _TopPodcastsShowcaseState();
}

class _TopPodcastsShowcaseState extends State<TopPodcastsShowcase> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<PodcastShow>>(
        future: PodcastSearchService().topPodcastShows,
        builder:
            (BuildContext context, AsyncSnapshot<List<PodcastShow>> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Chip(
                      label: Text(
                        snapshot.data[index].artistName,
                      ),
                    );
                  }),
            );
          } else {
            return Center(
              child: Column(
                children: [
                  Icon(Icons.history),
                  Text('No search history :('),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
