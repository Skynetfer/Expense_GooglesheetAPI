import 'package:flutter/material.dart';

class TextInCard extends StatelessWidget {
  const TextInCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('B A L A N C E',
        style: TextStyle(color: Colors.grey[500], fontSize: 16));
  }
}