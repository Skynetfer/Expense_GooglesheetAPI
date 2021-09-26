
import 'package:flutter/material.dart';

class IconAndMoneyExpenseInCard extends StatelessWidget {
  const IconAndMoneyExpenseInCard({
    Key? key,
    required this.expense,
  }) : super(key: key);

  final String expense;

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
              Icons.arrow_downward,
              color: Colors.red,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Expense',
                style: TextStyle(color: Colors.grey[500])),
            SizedBox(
              height: 5,
            ),
            Text('\$' + expense,
                style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }
}