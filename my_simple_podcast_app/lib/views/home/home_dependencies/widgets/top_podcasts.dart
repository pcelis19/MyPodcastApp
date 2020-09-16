import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_components/podcast_show_banner/podcast_show_banner.dart';
import 'package:my_simple_podcast_app/global_models/podcast_show.dart';
import 'package:my_simple_podcast_app/global_services/podcast_search_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TopPodcasts extends StatefulWidget {
  const TopPodcasts({Key key}) : super(key: key);

  @override
  _TopPodcastsState createState() => _TopPodcastsState();
}

class _TopPodcastsState extends State<TopPodcasts> {
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
            final PageController _controller =
                PageController(viewportFraction: 0.8);
            List<Widget> podcastShows = [];
            for (PodcastShow podcastShow in snapshot.data)
              podcastShows.add(PodcastShowBanner(
                podcastShow: podcastShow,
              ));
            return Container(
                child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: PageView(
                      controller: _controller,
                      children: podcastShows,
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: podcastShows.length,
                  )
                ],
              ),
            ));
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
