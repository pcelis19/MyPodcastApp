import 'package:flutter/cupertino.dart';
import 'package:my_simple_podcast_app/models/partial_podcast_information.dart';

class MVVMPodcastShow {
  final PartialPodcastInformation partialPodcastInformation;
  final Hero heroImage;
  MVVMPodcastShow(PartialPodcastInformation partialPodcastInformation)
      : this.partialPodcastInformation = partialPodcastInformation,
        this.heroImage = Hero(
            tag: partialPodcastInformation.imageUrl,
            child: Image.network(partialPodcastInformation.imageUrl));
}
