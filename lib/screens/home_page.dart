// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_blockchain/linking/contract_linking.dart';
import 'package:todolist_blockchain/screens/all_todos.dart';
import 'package:todolist_blockchain/screens/cached_data.dart';
import 'package:todolist_blockchain/screens/create_todo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _doNothing() {}
  void toCreate(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CreateTodo()));
  }

  @override
  Widget build(BuildContext context) {
    var contractLinking = Provider.of<ContractLinking>(context);
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 20,
        // width: 280,
        child: ListView(
          children: [
            const SizedBox(height: 50),
            CreateButton(
                text: "Add new data",
                onPressed: () {
                  toCreate(context);
                }),
            const SizedBox(height: 50),
            CreateButton(
              text: "View All Data",
              onPressed: () async {
                bool accessed = await contractLinking.getTodos();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllTodos(
                      accessed: accessed,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
            CreateButton(
              text: "View Cached",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CachedData()));
              },
            ),
            const SizedBox(height: 50),
            // CreateButton(
            //   text: "Mark Done",
            //   onPressed: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => MarkDone()));
            //   },
            // ),
            const SizedBox(height: 50),
            // CreateButton(
            //   text: "Delete Todo",
            //   onPressed: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => DeleteTodo()));
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class CreateButton extends StatelessWidget {
  CreateButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  String text;
  void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          onSurface: Colors.black,
          shadowColor: Colors.teal.shade700,
          backgroundColor: Colors.white70,
          elevation: 6.0,
          shape: const StadiumBorder(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Text(text, style: TextStyle(color: Colors.black, fontSize: 20)),
        ),
      ),
    );
  }
}
