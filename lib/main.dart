import 'package:billionnaireapp/addmoneybutton.dart';
import 'package:billionnaireapp/balancepart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double balance = 0;
  void addMoney() async {
    setState(() {
      balance = balance + 500;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('balance', balance);
  }

  void loadBalance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      balance = prefs.getDouble('balance') ?? 0;
    });
  }

  @override
  void initState() {
    loadBalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Billionnaire App!'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[800],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blueGrey[700],
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             BalanceView(balance: balance,),
              AddMoneyButton(addMoneyFunction: addMoney,)
            ],
          ),
        ),
      ),
    );
  }
}
