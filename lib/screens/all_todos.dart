import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_blockchain/linking/contract_linking.dart';

class AllTodos extends StatelessWidget {
  AllTodos({Key? key, required this.accessed}) : super(key: key);
  bool accessed;

  @override
  Widget build(BuildContext context) {
    var contractLinking = Provider.of<ContractLinking>(context);
    List<Task> allTodos = contractLinking.todos;
    return Scaffold(
        appBar: AppBar(
          title: Text("All Data - ${allTodos.length}"),
          backgroundColor: Colors.teal.shade700,
        ),
        body: accessed
            ? SizedBox(
                height: MediaQuery.of(context).size.height - 50,
                child: ListView.builder(
                    itemCount: allTodos.length,
                    itemBuilder: (context, index) {
                      if (allTodos.isEmpty) {
                        return const Center(
                          child: Text("HEHEHEHEHE Error"),
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
                                Text(allTodos[index].name),
                                Text(allTodos[index].aadhaar),
                                Text(allTodos[index].pan),
                                Text(allTodos[index].bank),
                                Text(allTodos[index].ifsc),
                                // Text(allTodos[index].branch),
                                // Text(allTodos[index].address),
                                Text(allTodos[index].phone),
                                Text(allTodos[index].doctor),
                                Text(allTodos[index].city),
                                Text(allTodos[index].pincode),
                                Text(allTodos[index].age.toString()),
                                Text(allTodos[index].amount.toString()),
                              ],
                            ),
                          ),
                        );
                      }
                    }),
              )
            : const Center(
                child: Text("Some Error occurred in blockchain"),
              ));
  }
}

// class AllTodos extends StatefulWidget {
//   const AllTodos({Key? key}) : super(key: key);
//
//   @override
//   State<AllTodos> createState() => _AllTodosState();
// }
//
// class _AllTodosState extends State<AllTodos> {
//   // ContractLinking linking = ContractLinking();
//   // late Future<List<Task>> allList;
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   allList = linking.getTodos();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     var contractLinking = Provider.of<ContractLinking>(context);
//     contractLinking.getTodos();
//     //
//     //
//     // Future<List<Task>> getTasks() {
//     //   return contractLinking.getTodos();
//     // }
//
//     return SafeArea(
//       child: Scaffold(
//           appBar: AppBar(
//             title: Text("All Todos"),
//             backgroundColor: Colors.teal.shade700,
//           ),
//           body: Consumer<ContractLinking>(
//             builder: (context, controller, _) {
//               return ListView.builder(
//                 itemCount: controller.todos.length,
//                 itemBuilder: (context, index) {
//                   print('indidde lsit');
//                   if (Provider.of<ContractLinking>(context).todos.isEmpty) {
//                     print("nodata");
//                     return Center(
//                       child: Text("Hello There, koi data nahi hai"),
//                     );
//                   } else {
//                     print("hidni");
//                     return Row(
//                       children: [
//                         Text(controller.todos[index].id.toString()),
//                         Text(controller.todos[index].content),
//                         Text(controller.todos[index].completed.toString()),
//                       ],
//                     );
//                   }
//                 },
//               );
//             },
//           )
//           // FutureBuilder(
//           //   future: getTasks(),
//           //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           //     if (snapshot.connectionState == ConnectionState.waiting) {
//           //       return const Center(
//           //         child: Text("Loading datataaaaa....."),
//           //       );
//           //     } else if (snapshot.hasError) {
//           //       // print(snapshot.data);
//           //       // print(allList.toString());
//           //       return const Center(
//           //           child: Text("Eroror in loading data heehhehe"));
//           //     } else {
//           //       return Center(
//           //         child: SizedBox(
//           //           height: MediaQuery.of(context).size.height - 100,
//           //           child: ListView.builder(
//           //             itemCount: snapshot.data.length,
//           //             itemBuilder: (BuildContext context, int index) {
//           //               return Padding(
//           //                 padding: const EdgeInsets.all(20.0),
//           //                 child: Container(
//           //                   padding: EdgeInsets.all(10),
//           //                   height: 70,
//           //                   width: 100,
//           //                   decoration: BoxDecoration(
//           //                       color: Colors.grey,
//           //                       borderRadius: BorderRadius.circular(20)),
//           //                   child: Row(
//           //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           //                     children: [
//           //                       Text((snapshot.data[index].id).toString()),
//           //                       Text(snapshot.data[index].content),
//           //                       Text(snapshot.data[index].completed.toString())
//           //                     ],
//           //                   ),
//           //                 ),
//           //               );
//           //             },
//           //           ),
//           //         ),
//           //       );
//           //     }
//           //   },
//           // ),
//           ),
//     );
//   }
// }
//
// Future<void> runAfterBuild() async {}
