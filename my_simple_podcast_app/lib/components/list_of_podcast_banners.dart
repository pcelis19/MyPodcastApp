import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/constants/decorations.dart';
import 'package:my_simple_podcast_app/models/partial_podcast_information.dart';
import 'package:my_simple_podcast_app/widgets/podcast_banner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ListOfPodcastBanners extends StatefulWidget {
  const ListOfPodcastBanners({Key key, @required this.listOfPodcasts})
      : super(key: key);

  @override
  _ListOfPodcastBannersState createState() => _ListOfPodcastBannersState();
  final List<PartialPodcastInformation> listOfPodcasts;
}

class _ListOfPodcastBannersState extends State<ListOfPodcastBanners> {
  final List<PodcastBanner> podcastBanners = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.listOfPodcasts.forEach(
        (element) => podcastBanners.add(PodcastBanner(podcastShow: element)));
  }

  @override
  Widget build(BuildContext context) {
    final PageController _controller =
        PageController(viewportFraction: kBannerPercentWidth);

    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _controller,
            children: podcastBanners,
          ),
        ),
        SmoothPageIndicator(
          controller: _controller,
          count: podcastBanners.length,
        )
      ],
    );
  }
}
