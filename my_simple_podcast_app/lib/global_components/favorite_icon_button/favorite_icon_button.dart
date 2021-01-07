import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/partial_podcast_information.dart';
import 'package:provider/provider.dart';

/// Make sure to house this under a provider
class FavoriteIconButton extends StatefulWidget {
  const FavoriteIconButton({
    Key key,
    @required this.partialPodcastInformation,
  }) : super(key: key);
  final PartialPodcastInformation partialPodcastInformation;

  @override
  _FavoriteIconButtonState createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.partialPodcastInformation,
      builder: (context, child) {
        return Consumer<PartialPodcastInformation>(
          builder: (context, podcastShow, child) {
            if (loading) return _waitingIndicator();
            return IconButton(
              icon: Icon(
                  podcastShow.isFavorited
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded,
                  color: podcastShow.isFavorited ? Colors.red : Colors.grey),
              onPressed: loading
                  ? null
                  : () async {
                      setState(() {
                        loading = true;
                      });
                      await podcastShow.toggleFavorites();
                      setState(() {
                        loading = false;
                      });
                    },
            );
          },
        );
      },
    );
  }

  Widget _waitingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
            height: 24, width: 24, child: CircularProgressIndicator()),
      ),
    );
  }
}
