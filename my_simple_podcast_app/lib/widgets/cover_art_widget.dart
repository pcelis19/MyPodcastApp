import 'package:flutter/material.dart';

class CoverArt extends StatelessWidget {
  const CoverArt({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.network(imageUrl),
      ),
    );
  }
}
