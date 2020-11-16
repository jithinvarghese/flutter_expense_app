import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  // This is to stop the landcape mode
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.green,
          accentColor: Colors.amber,
          errorColor: Colors.red[300],
          fontFamily: 'Quicksand',
          textTheme: TextTheme(
            headline1: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
            headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 18.0),
            bodyText2: TextStyle(fontFamily: 'OpenSans', fontSize: 14.0),
            button: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline1: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 25,
                      color: Colors.white),
                  headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 22.0),
                  bodyText2: TextStyle(fontFamily: 'OpenSans', fontSize: 14.0),
                ),
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
  final List<Transaction> _userTransaction = [];

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

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
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
            child: NewTransaction(
              _addNewTransaction,
            ),
            behavior: HitTestBehavior.opaque, //
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Expense App'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      //  SingleChildScrollView( // add SingleChildScrollView on the main body.it wont able to work inside.
      //   child
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.4,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.6,
              child: TransactionList(_userTransaction, _deleteTransaction),
            ),
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
