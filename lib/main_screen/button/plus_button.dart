import 'package:flutter/material.dart';
import 'package:flutter_expense_googsheet_api/main_screen/button/components/content_button.dart';

class PlusButton extends StatelessWidget {
  final function;

  PlusButton({this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 75,
        width: 75,
        decoration: BoxDecoration(
          color: Colors.grey[500],
          shape: BoxShape.circle,
        ),
        child: ContentButton(),
      ),
    );
  }
}



