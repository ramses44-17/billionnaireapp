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
  void addMoney() {
    setState(() async {
      balance = balance + 500;
      // Obtain shared preferences.
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('balance', balance);
    });
  }

  void loadBalance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      balance = prefs.getDouble('balance') ?? 0;
    });
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
              Expanded(
                flex: 9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('bank balance: '),
                    SizedBox(
                      height: 20,
                    ),
                    Text('$balance')
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                        minimumSize: const Size(double.infinity, 0)),
                    onPressed: addMoney,
                    child: const Text('Add oney')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
