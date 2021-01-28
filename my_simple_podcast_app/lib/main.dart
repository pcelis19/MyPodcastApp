import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_utils/route_names.dart';
import 'package:my_simple_podcast_app/views/home/home_screen.dart';
import 'package:my_simple_podcast_app/views/podcast_home_screen/podcast_home_screen.dart';
import 'package:provider/provider.dart';

import 'global_models/partial_podcast_information.dart';
import 'global_services/audio_player/audio_player.dart';
import 'global_services/favorite_podcasts/favorites_podcasts_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavoritePodcastsService().intializeFavorites();
  await AudioPlayer().intializeAudioPlayer();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FavoritePodcastsService _favoritePodcastsService =
      FavoritePodcastsService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: _favoritePodcastsService,
          ),
          ChangeNotifierProvider.value(
            value: _audioPlayer,
          ),
        ],
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.indigo, accentColor: Colors.redAccent),
            routes: {
              kDefault: (context) => HomePage(),
              kPodcastHomeScreen: (context) => PodcastHomeScreen(
                    partialPodcastInformation: (ModalRoute.of(context)
                        .settings
                        .arguments as PartialPodcastInformation),
                  )
            },
          );
        });
  }
}

/// TESTING CODE///
// Map<String, dynamic> dummyJsonFile = {
//   "artistName": "Ascension Catholic Faith Formation",
//   "contentAdvisoryRating": "",
//   "country": "USA",
//   "feedUrl": "https://feeds.fireside.fm/bibleinayear/rss",
//   "genres": [
//     "christianity",
//     "podcasts",
//     "religion & spirituality",
//     "history"
//   ],
//   "imageUrl":
//       "https://is4-ssl.mzstatic.com/image/thumb/Podcasts124/v4/5d/02/0b/5d020b6a-7744-612d-272e-ee7bc9ab7f68/mza_14734368724766946598.jpg/600x600bb.jpg",
//   "podcastId": null,
//   "podcastName": "The Bible in a Year (with Fr. Mike Schmitz)",
//   "releaseDate": "2021-01-03 05:00:00.000Z"
// };
// PartialPodcastInformation dummyPodcast =
//     PartialPodcastInformation.fromJson(dummyJsonFile);
