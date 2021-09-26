import 'package:flutter/material.dart';

class BalanceInCard extends StatelessWidget {
  const BalanceInCard({
    Key? key,
    required this.balance,
  }) : super(key: key);

  final String balance;

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$' + balance,
      style: TextStyle(color: Colors.grey[800], fontSize: 40),
    );
  }
}