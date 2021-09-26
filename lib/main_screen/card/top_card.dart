import 'package:flutter/material.dart';
import 'package:flutter_expense_googsheet_api/main_screen/card/components/balance_in_card.dart';
import 'package:flutter_expense_googsheet_api/main_screen/card/components/content_expense_in_card.dart';
import 'package:flutter_expense_googsheet_api/main_screen/card/components/content_income_in_card.dart';
import 'package:flutter_expense_googsheet_api/main_screen/card/components/shadow_card.dart';
import 'package:flutter_expense_googsheet_api/main_screen/card/components/text_content_in_card.dart';

class TopNeuCard extends StatelessWidget {
  final String balance;
  final String income;
  final String expense;

  TopNeuCard({
    required this.balance,
    required this.expense,
    required this.income,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextInCard(),
              BalanceInCard(balance: balance),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconAndMoneyIncomeInCard(income: income),
                    IconAndMoneyExpenseInCard(expense: expense)
                  ],
                ),
              )
            ],
          ),
        ),
        decoration: shadow_Card(),
      ),
    );
  }

  
}







