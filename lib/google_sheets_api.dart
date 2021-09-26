import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "earnest-dogfish-327008",
  "private_key_id": "1dc4146a0a4ad903af46a62a31019ca81f864d61",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDeZKnollvqs9mM\n0lAEg9Jgq5BsBmf+n+/3L3K+qnD6tCF9XtT2W5w1gNj29K3antutG6KslfbOvZOM\nyxBqmrO75C7XjO0BfYG86fTtbigSY4kYZjSevTi/HO2ZwIZ2O3zZ1rBG0RTm4R2d\nb2/eTl90uFWYuGx3G1UyCTWZZZycQSdcVxyo+wvn2IRCHsqSfwCjUqls8prcoaW5\nTZ8HNqum587AXdFSuyh/uIrrppsNbrm46qfjog7ps+HpH2OymE6wLM8JCGqyDVsf\nS7u+DXAlDfY8JrRYKLDQ19ev25PU0EuVr9JBQaXCi7u5U0DRE6soUKi8nD/Ps91R\n/2bwSAqjAgMBAAECggEAaeT42p0t61X0Ew/Ztiymsg0/WZC7WA0EEGlxc8Row5ee\nErpjIWOBwCA4L29WkTDvXUA5d4B44vx2E6ZljL1ZM/B1NYIPIJSIgFHOpHe9cPQg\nRZP1HljvemDl6j44SHgO/RMzIKVSFJXAqkRzuiELZuKXL38xdo13RboI4Z/2sJea\nUPn6JGsLQ5CiJrY/yeJ9/Ylpnuie8Bmwy4bsIE53DUDU5btPQfnSrmwSvc5feXQz\n3NXyAs0JChAFh1PcNhjBfUI8Ddjza4Ijm9jfC7KNMJgn8qEku+5IBAbkQQhcGea7\nJAUeFZ096C0emRqR0uFjEG+pWyn9uFfMFRQmalgNAQKBgQDvE8oxrVxWR4XkoKo+\noYyXX2Y/HeI93Io2AypcDk0TJRHcLEOnzzh8Licwy3/wrZRDDUxfADL3U8/+Zlah\nvquw5a1e6IzXjJ/X2ioKdGP/TzF2Yhyq6wSjGRX2AZk/i7loHNwuYsm/EK483U1a\n5k2jKjPeJ8jg3UsadERZwy4rwQKBgQDuIoyY1Ex/AIS3ffJvKXvFwH25NTy2gvdB\nNCm6lh7Xj91g9fw6PQh3tyeERsOjXrlTql94rRn5MMfq/3NL/HKy11jJ201YeHvx\nHZ6PRWpuIp5+Fvdatvbm1Jf1iK6KiqlpbgdavI93NptNjeY1WS70gKAAKQDo5SPM\ndQTF0VDfYwKBgBDPU2gqyFNItCFfKpk8wqXiD05gy4eN+inSDyhp2QF/mcHhWuBx\nsYcJt7e2l0hU7BfK15PWb770Jau9hlnZDjlh7M6/iyecu6BxtoMFrAJHjzLDs0BR\nRgIxwVmKwzu0l1S6ssCQMZ89jQK6jLXXe539WahFI9qrtJwnkKa/EoABAoGAaHgx\ntA5W7NR+ZL1VMR1C1nNm9Gx9kRgNfsZylA+twiW0GghwOeByqYppRKeCxlYU+bZh\noeBW57JV0it1Gl3Kt9ivdAbIfMqGnTXATNxIH78CRxCuPVbNJGEZtTbcU50XS1Bg\n25ajXcpQAYsB9l+EsPEIwGk8o+96cATaLipwzz8CgYEAtTKNyFo8GjIt3BWONx0S\npywxXglvpCrgXOSNMs8TetHCycCk0gY0QFSt3OzvP0TkZ514bAgz2zFm9CfGHHB5\nyCdNdIeLCBccpR3tq7jO1W2SoPYW+ixFf2HY7gzR/nYxB3uaxfurr+eMKNoTUIY7\ncwdvD3c2z6N4fBDx+19SosU=\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-google-sheet-api@earnest-dogfish-327008.iam.gserviceaccount.com",
  "client_id": "104284578239830467438",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-google-sheet-api%40earnest-dogfish-327008.iam.gserviceaccount.com"
  }

  ''';

  // set up & connect to the spreadsheet
  static final _spreadsheetId = '1obGQjI2bj42yB9kZ94yqs5Hxr82fqcdHXxIqeu8CvVk';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  // some variables to keep track of..
  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  // initialise the spreadsheet!
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();
  }

  // count the number of notes
  static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    // now we know how many notes to load, now let's load them!
    loadTransactions();
  }

  // load existing notes from the spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    print(currentTransactions);
    // this will stop the circular loading indicator
    loading = false;
  }

  // insert a new transaction
  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }

  // CALCULATE THE TOTAL INCOME!
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // CALCULATE THE TOTAL EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }
}
