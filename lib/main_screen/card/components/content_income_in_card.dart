import 'package:flutter/material.dart';

class IconAndMoneyIncomeInCard extends StatelessWidget {
  const IconAndMoneyIncomeInCard({
    Key? key,
    required this.income,
  }) : super(key: key);

  final String income;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
          ),
          child: Center(
            child: Icon(
              Icons.arrow_upward,
              color: Colors.green,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Income', style: TextStyle(color: Colors.grey[500])),
            SizedBox(
              height: 5,
            ),
            Text('\$' + income,
                style: TextStyle(
                    color: Colors.grey[600], fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }
}
