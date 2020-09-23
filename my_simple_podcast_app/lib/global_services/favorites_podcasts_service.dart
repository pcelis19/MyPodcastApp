import 'package:my_simple_podcast_app/global_models/podcast_show.dart';

class FavoritePodcastsService {
  static final FavoritePodcastsService _favoritesPodcastsService =
      FavoritePodcastsService.internal();
  factory FavoritePodcastsService() {
    return _favoritesPodcastsService;
  }
  FavoritePodcastsService.internal();
  Future<List<Podcast>> get favoritePodcasts {}
}
