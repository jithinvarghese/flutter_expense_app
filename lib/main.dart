import 'package:flutter/material.dart';
import './widgets/user_transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense App'),
      ),
      //  SingleChildScrollView( // add SingleChildScrollView on the main body.it wont able to work inside.
      //   child
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Card(
                color: Colors.red, //means background color
                child: Text('chart'),
                elevation: 10,
                shadowColor: Colors.pink,
              ),
            ),
            UserTransaction(),
          ],
        ),
      ),
    );
  }
}
