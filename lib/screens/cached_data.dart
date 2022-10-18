import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CachedData extends StatelessWidget {
  const CachedData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var taskBox = Hive.box('task-box');
    print(taskBox.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cached Data"),
        backgroundColor: Colors.teal.shade700,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 50,
        child: ListView.builder(
            itemCount: taskBox.length,
            itemBuilder: (context, index) {
              if (taskBox.isEmpty) {
                return const Center(
                  child: Text("No Data"),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 50,
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text((index + 1).toString()),
                        Text(taskBox.getAt(index).name),
                        Text(taskBox.getAt(index).aadhaar),
                        Text(taskBox.getAt(index).pan),
                        Text(taskBox.getAt(index).bank),
                        Text(taskBox.getAt(index).ifsc),
                        // Text(allTodos[index].branch),
                        // Text(allTodos[index].address),
                        Text(taskBox.getAt(index).phone),
                        Text(taskBox.getAt(index).doctor),
                        Text(taskBox.getAt(index).city),
                        Text(taskBox.getAt(index).pincode),
                        Text(taskBox.getAt(index).age.toString()),
                        Text(taskBox.getAt(index).amount.toString()),
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
