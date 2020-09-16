import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  const PillButton({
    Key key,
    @required this.function,
    @required this.label,
  }) : super(key: key);
  final Function function;
  final String label;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: function,
      child: Text(label),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
