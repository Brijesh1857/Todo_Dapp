import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todolist_blockchain/linking/contract_linking.dart';
import './screens/home_page.dart';

void main() async{

  await Hive.initFlutter();
  Hive.openBox('task-box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContractLinking()),
      ],
      child: MaterialApp(
        title: "TodoList",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("TodoList"),
            backgroundColor: Colors.teal.shade700,
          ),
          body: HomePage(),
        ),
      ),
    );
  }
}
