import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/podcast_show.dart';

class ShowTitle extends StatelessWidget {
  const ShowTitle({
    Key key,
    @required this.showName,
  }) : super(key: key);
  final String showName;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AutoSizeText(
        showName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
