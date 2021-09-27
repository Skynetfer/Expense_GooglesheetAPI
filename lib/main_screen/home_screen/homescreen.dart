import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_googsheet_api/main_screen/api/google_sheets_api.dart';
import 'package:flutter_expense_googsheet_api/main_screen/button/plus_button.dart';
import 'package:flutter_expense_googsheet_api/main_screen/card/top_card.dart';
import 'package:flutter_expense_googsheet_api/main_screen/home_screen/components/list_items_bottom_bar.dart';
import 'package:flutter_expense_googsheet_api/main_screen/loading_layout/loading_circle.dart';
import 'package:flutter_expense_googsheet_api/transaction/transaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final int _index = 0;
  bool _isIncome = false;

  // enter the new transaction into the spreadsheet
  void _enterTransaction() {
    GoogleSheetsApi.insert(
      _textcontrollerITEM.text,
      _textcontrollerAMOUNT.text,
      _isIncome,
    );
    setState(() {});
  }

  // add new transaction
  void _newTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: AlertDialog(
                  title: Text(
                    'NEW TRANSACTION',
                    textAlign: TextAlign.center,
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Expense'),
                            Switch(
                              value: _isIncome,
                              onChanged: (newValue) {
                                setState(() {
                                  _isIncome = newValue;
                                });
                              },
                            ),
                            Text('Income'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Amount?',
                                  ),
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Enter an amount';
                                    }
                                    return null;
                                  },
                                  controller: _textcontrollerAMOUNT,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'For what?',
                                ),
                                controller: _textcontrollerITEM,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      color: Colors.grey[600],
                      child:
                          Text('Cancel', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    MaterialButton(
                      color: Colors.grey[600],
                      child:
                          Text('Enter', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _enterTransaction();
                          Navigator.of(context).pop();
                        }
                      },
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  // wait for the data to be fetched from google sheets
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
      startLoading();
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TopNeuCard(
              balance: (GoogleSheetsApi.calculateIncome() -
                      GoogleSheetsApi.calculateExpense())
                  .toString(),
              income: GoogleSheetsApi.calculateIncome().toString(),
              expense: GoogleSheetsApi.calculateExpense().toString(),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: GoogleSheetsApi.loading == true
                            ? LoadingCircle()
                            : ListView.builder(
                                itemCount:
                                    GoogleSheetsApi.currentTransactions.length,
                                itemBuilder: (context, index) {
                                  return MyTransaction(
                                    transactionName: GoogleSheetsApi
                                        .currentTransactions[index][0],
                                    money: GoogleSheetsApi
                                        .currentTransactions[index][1],
                                    expenseOrIncome: GoogleSheetsApi
                                        .currentTransactions[index][2],
                                  );
                                }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            PlusButton(
              function: _newTransaction,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.white,
        backgroundColor: (Colors.grey[300])!,
        animationDuration: Duration(seconds: 1),
        animationCurve: Curves.bounceOut,
        items: ItemInBottomBar,
        index: _index,
        onTap: (index) {
          setState(() {
            index = _index;
          });
        },
      ),
    );
  }
}
