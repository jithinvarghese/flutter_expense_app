import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    headline3: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                )),
          )), //global asses to the desing to the app it included text,input feild
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //     id: 't1', title: 'new show', amount: 89.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'new show', amount: 99.9999, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  // where  - > it will allow to run every funcation of item in the list and if the
  //funcation return true,it will give a list other wise it wont keep the list

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    //_ make the method private
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {}, //does nothing just catch
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque, //
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense App'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      //  SingleChildScrollView( // add SingleChildScrollView on the main body.it wont able to work inside.
      //   child
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
