import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/podcast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'podcast_banner.dart';

class ListOfPodcastBanners extends StatefulWidget {
  const ListOfPodcastBanners({
    Key key,
    @required this.listOfPodcasts,
    @required this.maxHeight,
  }) : super(key: key);

  final List<Podcast> listOfPodcasts;
  final double maxHeight;

  @override
  _ListOfPodcastBannersState createState() => _ListOfPodcastBannersState();
}

class _ListOfPodcastBannersState extends State<ListOfPodcastBanners> {
  List<Widget> podcasts = [];
  Podcast currentFocusPodcast;
  final PageController _controller = PageController(viewportFraction: 0.8);
  @override
  void initState() {
    super.initState();
    currentFocusPodcast = widget.listOfPodcasts[0];
    currentFocusPodcast.giveFocus();
    for (Podcast podcastShow in widget.listOfPodcasts) {
      podcasts.add(
        PodcastBanner(
          podcastShow: podcastShow,
          maxHeight: widget.maxHeight,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: widget.maxHeight,
            width: double.infinity,
            child: PageView(
              controller: _controller,
              children: podcasts,
              onPageChanged: updateFocusWidget,
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: podcasts.length,
          )
        ],
      ),
    );
  }

  void updateFocusWidget(int index) {
    Podcast previousFocusPodcast = currentFocusPodcast;
    currentFocusPodcast = widget.listOfPodcasts[index];
    previousFocusPodcast.removeFocus();
    currentFocusPodcast.giveFocus();
  }
}
