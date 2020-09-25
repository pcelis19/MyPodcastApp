import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/podcast.dart';
import 'package:provider/provider.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({
    Key key,
    @required Podcast podcastShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Podcast>(
      builder: (context, podcastShow, child) {
        return FutureBuilder<bool>(
          future: podcastShow.isFavorited,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return UpdateFavoritesIcon(
                podcast: podcastShow,
                isFavorite: snapshot.data,
              );
            } else {
              return _waitingIndicator();
            }
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

class UpdateFavoritesIcon extends StatefulWidget {
  const UpdateFavoritesIcon(
      {Key key, @required Podcast podcast, bool isFavorite})
      : _podcast = podcast,
        _isFavorite = isFavorite,
        super(key: key);
  final Podcast _podcast;
  final bool _isFavorite;
  @override
  _UpdateFavoritesIconState createState() => _UpdateFavoritesIconState();
}

class _UpdateFavoritesIconState extends State<UpdateFavoritesIcon> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    if (loading) return _waitingIndicator();
    return IconButton(
      icon: Icon(
          widget._isFavorite
              ? Icons.favorite_rounded
              : Icons.favorite_outline_rounded,
          color: _themeData.primaryIconTheme.color),
      onPressed: loading
          ? null
          : () async {
              setState(() {
                loading = true;
              });
              await widget._podcast.toggleFavorites();
              setState(() {
                loading = false;
              });
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
