import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/podcast.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({
    Key key,
    @required Podcast podcastShow,
  })  : _podcastShow = podcastShow,
        super(key: key);

  final Podcast _podcastShow;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _podcastShow.isFavorited,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return UpdateFavoritesIcon(
            podcast: _podcastShow,
            isFavorite: snapshot.data,
          );
        } else {
          return _waitingIndicator();
        }
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

bool loading = false;

class _UpdateFavoritesIconState extends State<UpdateFavoritesIcon> {
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
