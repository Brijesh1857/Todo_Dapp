import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todolist_blockchain/linking/contract_linking.dart';
import 'package:todolist_blockchain/screens/create_todo.dart';
import 'package:todolist_blockchain/screens/home_page.dart';

class CachedData extends StatefulWidget {
  const CachedData({Key? key}) : super(key: key);

  @override
  State<CachedData> createState() => _CachedDataState();
}

class _CachedDataState extends State<CachedData> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int count = 0;
    var taskBox = Hive.box('task-box');
    var contractLinking = Provider.of<ContractLinking>(context);
    // print(taskBox.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cached Data - ${taskBox.length}"),
        backgroundColor: Colors.teal.shade700,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add to blockchain",
        onPressed: () {
          int length = taskBox.length;
          setState(() {
            isLoading = true;
          });
          if (length == 0) {
            setState(() {
              isLoading = true;
            });
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Empty"),
                content: Text("No data to upload"),
                actions: [
                  TextButton(
                    onPressed: () {
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    },
                    child: const Text("Ok"),
                  )
                ],
              ),
            );
            return;
          }

          String transactionHash = "";
          var start = DateTime.now();
          contractLinking.sendTransactions().then(
            (value) {
              setState(() {
                isLoading = false;
              });
              transactionHash = value;
              // Navigator.pop(context);
              var end = DateTime.now();
              var timeTaken = end.difference(start);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title:
                      Text(transactionHash.isNotEmpty ? "Todo Added" : "Error"),
                  content: Text(transactionHash.isNotEmpty
                      ? "Transaction Hash: $transactionHash\nTime Taken = $timeTaken"
                      : "Error occurred in accessing blockchain"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        int count = 0;
                        Navigator.of(context).popUntil((_) => count++ >= 2);
                      },
                      child: const Text("Ok"),
                    )
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.upload),
      ),
      body: Stack(
        children: [
          SizedBox(
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
                            Text(taskBox.getAt(index)["name"]),
                            Text(taskBox.getAt(index)["aadhaar"]),
                            Text(taskBox.getAt(index)["pan"]),
                            Text(taskBox.getAt(index)["bank"]),
                            Text(taskBox.getAt(index)["ifsc"]),
                            // Text(allTodos[index].branch),
                            // Text(allTodos[index].address),
                            Text(taskBox.getAt(index)["phone"]),
                            Text(taskBox.getAt(index)["doctor"]),
                            Text(taskBox.getAt(index)["city"]),
                            Text(taskBox.getAt(index)["pincode"]),
                            Text(taskBox.getAt(index)["age"].toString()),
                            Text(taskBox.getAt(index)["amount"].toString()),
                          ],
                        ),
                      ),
                    );
                  }
                }),
          ),
          Positioned(
            bottom: 15,
            right: 90,
            child: CreateButton(
              text: "Generate Random",
              onPressed: () {
                setState(() {
                  taskBox.add(<String, dynamic>{
                    "id": count,
                    "name": "ABC",
                    "phone": "1234567890",
                    "aadhaar": "98765",
                    "age": 52,
                    "amount": 1000,
                    "bank": "SBI",
                    "city": "Kanpur",
                    "doctor": "Doctor",
                    "ifsc": "SBIN",
                    "pan": "BSCPN",
                    "pincode": "209305"
                  });
                  ++count;
                });
              },
            ),
          ),
          loadingOverlay(loading: isLoading),
        ],
      ),
    );
  }
}
