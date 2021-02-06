import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/models/partial_podcast_information.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'podcast_banner.dart';

class ListOfPodcastBanners extends StatefulWidget {
  @override
  _ListOfPodcastBannersState createState() => _ListOfPodcastBannersState();
}

class _ListOfPodcastBannersState extends State<ListOfPodcastBanners> {
  final List<PodcastBanner> podcasts = [];
  PodcastBanner currentFocusPodcast;
  final PageController _controller = PageController(viewportFraction: 0.8);
  @override
  void initState() {
    super.initState();
    context.watch<List<PartialPodcastInformation>>().forEach(
        (PartialPodcastInformation podcast) =>
            podcasts.add(PodcastBanner(podcastShow: podcast)));
    currentFocusPodcast = podcasts[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
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
    PodcastBanner previousFocusPodcast = currentFocusPodcast;
    currentFocusPodcast = podcasts[index];
    // previousFocusPodcast.removeFocus();
    // currentFocusPodcast.giveFocus();
  }
}
