import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/podcast_show.dart';
import 'package:my_simple_podcast_app/global_services/favorites_podcasts_service.dart';

class FavoritePodcasts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Podcast>>(
      future: FavoritePodcastsService().favoritePodcasts,
      builder: (context, snapshot) {},
    );
  }
}
