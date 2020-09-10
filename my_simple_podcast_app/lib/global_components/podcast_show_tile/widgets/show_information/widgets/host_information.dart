import 'package:flutter/material.dart';

class HostInformation extends StatelessWidget {
  const HostInformation({
    Key key,
    @required this.artistName,
  }) : super(key: key);
  final String artistName;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text("host: $artistName"),
    );
  }
}
