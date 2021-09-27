import 'package:flutter/material.dart';
import 'package:flutter_expense_googsheet_api/main_screen/api/google_sheets_api.dart';
import 'package:flutter_expense_googsheet_api/main_screen/home_screen/homescreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetsApi().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
