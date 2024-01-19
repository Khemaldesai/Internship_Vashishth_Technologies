import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
  {
   
  "type": "service_account",
  "project_id": "helpful-aurora-411604",
  "private_key_id": "a8711141378dade522b7933785a4422afc137921",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDlyWo01kG8CP/3\n0HQQjm8Z/R52UAYvd5gNl3xlWJnMM7ppLg0BiE3s2KspTNxX82mMe3fFvmvFSAn4\nk1CW9ixgMs93uBGwjU00RUQH4ZDRi3rBL098HJbl8AJR8JYaDu3QjTbAjMIuneAQ\nZZjeU1Yk1Bl8rJqx2JKGC533n+HCouETp6Rnf/8kLR9rSlgwMbozQvJQHEN6uw2H\n3blriVLaXKfQb/CdKttBk4hdEEWwh4vznRODaLK5qz5h/bCocjIxiTfnJV9RxNmm\ndzbt4NmG+MNnwt8/tjdQc8jHeP9cqz4y4GgmYQvo9oYl5UEpA+/ZaXEno6BUoKsF\nZuKgja0vAgMBAAECggEABLZctzitoG2O0kY0GyLQpHfMaCC7/700IRM6OdnXTZjB\n+eY33hAtiO3olLA+1I7pWzgs/KErFKClk7Nxs6bYwiBIoOvlcPl0292Px5mYnrN9\nkPinaKQtdAm4AnYsndwwhFZhCRHZ6ZrTPYLX37dVzOuMmkHv6jXGy3jxhGKC/rrO\ncC58ERc4vlueBff2Knt7Zx4tkQP3QR6cOEfdqNycPdYeqeMGsDPKec/SLlu/XauQ\n1QAfQ6z4KWFMR8hgKEiOlkPxhmVfM9cXkudBeAttCOLQa7RaqxtZAiVDZCsWFn71\nEqftXW/DFyxzr3K5K9yNCoIHxQHRGQ41uSwvzAzAAQKBgQDypBJCoGMzzzq1W8FO\nf51IKd1tehmX2c+k85hFsYfjE9gJMWWaRo38mdjwkwxCelas2NQzwXpSjmfSpajV\nj4YEeC8B00hkCW/a4JGMNeW5qvrFXrc1OxuOhcXLbwYUnc55DFo+r+ym9VcBQ0v3\n0xRwowXe70x94iu84wx+Iu6ugQKBgQDycCtuDJTTaXMahUChmu7Ax5JXRnr//kdY\nB012ordSW2bPYcQh6fM3fiYF2aX4RmT3YLK6dnVDh/AOk9NX7JiVkUBYrfpkMcy5\n0k+AL233a0JQmmv5W9bT75SN1bD2onkK8D0D3p716pFCnlSY1+SoiNn+mAnH/sdy\n0sBNlqjjrwKBgDslIUpaXDQZ1H62sgUXeFhJ1C7Gb4yjTEkyE7ERWEVS5fs/rjuP\n7TZgrg/eWEOwHIafiAJhrBaJnecr+F6uUIWwYgz42pF/92MMEI5z6N58Pgp0TwZL\ntSjllNRE6N+Ho/e/uhPDwFTmQuIM7GypaDcYlerEvAmHYw/07GumyjWBAoGAC5Ba\nIferqaHgAaXVfV/cf4mFa3BLMaa5VHOUuFHumJkPgFjTeCKmnUEBI0pMZllFO597\nJvW7hisXwjo+3HTGmmvBO/mgdeMCNuLXM/APOLv+/8U93TkKODW3SkSlGj6Js4He\nBy85OdWkdB8FPf0eRQOyEjjCTq3SaaGv1oOXLrUCgYEAz/imuxMiCUm+J3SA6G8C\nYIoKBzDnMRdd7Z+nSLwn/dxWzSLoi3UHdvbGY5SxtF0BAHguOgv5Y+peQ1uWioiW\ngkAdwaZ21Qgo9Mb+3q8M7YBR5oYE2ax2Bqd40hqwVOfl3VdQRu0c1/gaue5HbN00\noF16EskqSp8rBuAgKw54Xq0=\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheets-tutorial@helpful-aurora-411604.iam.gserviceaccount.com",
  "client_id": "103501745049124936496",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets-tutorial%40helpful-aurora-411604.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
  
  }
  ''';

  // set up & connect to the spreadsheet
  static final _spreadsheetId = '11DABGQpTGzla4hIgmG5MSL7hHISHb3vzM6LtSZl6pnU';
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
