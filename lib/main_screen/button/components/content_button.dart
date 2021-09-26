import 'package:flutter/material.dart';

class ContentButton extends StatelessWidget {
  const ContentButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '+',
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
