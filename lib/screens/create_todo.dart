import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todolist_blockchain/linking/contract_linking.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var contractLinking = Provider.of<ContractLinking>(context);
    // TextEditingController contentController = TextEditingController();

    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController aadhaarController = TextEditingController();
    TextEditingController panController = TextEditingController();
    TextEditingController bankController = TextEditingController();
    TextEditingController ifscController = TextEditingController();
    // TextEditingController branchController = TextEditingController();
    // TextEditingController addressController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController doctorController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController pincodeController = TextEditingController();
    TextEditingController amountController = TextEditingController();

    contractLinking.initialSetup();
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Create Todo"),
            backgroundColor: Colors.teal.shade700,
          ),
          body: Stack(
            children: [
              SizedBox(
                height: size.height - 10,
                child: ListView(
                  children: [
                    const SizedBox(height: 50),
                    Center(
                      child: CreateInputField(
                        size: size,
                        contentController: nameController,
                        title: "Name",
                      ),
                    ),
                    Center(
                      child: CreateInputField(
                        size: size,
                        contentController: ageController,
                        title: "Age",
                      ),
                    ),
                    Center(
                      child: CreateInputField(
                        size: size,
                        contentController: aadhaarController,
                        title: "Aadhaar",
                      ),
                    ),
                    Center(
                      child: CreateInputField(
                        size: size,
                        contentController: panController,
                        title: "Pan Number",
                      ),
                    ),
                    Center(
                      child: CreateInputField(
                        size: size,
                        contentController: bankController,
                        title: "Bank Ac",
                      ),
                    ),
                    Center(
                      child: CreateInputField(
                        size: size,
                        contentController: ifscController,
                        title: "IFSC Code",
                      ),
                    ),
                    // Center(
                    //   child: CreateInputField(
                    //     size: size,
                    //     contentController: branchController,
                    //     title: "Branch Name",
                    //   ),
                    // ),
                    // Center(
                    //   child: CreateInputField(
                    //     size: size,
                    //     contentController: addressController,
                    //     title: "Address",
                    //   ),
                    // ),
                    Center(
                      child: CreateInputField(
                        size: size,
                        contentController: phoneController,
                        title: "Mobile Number",
                      ),
                    ),
                    Center(
                      child: CreateInputField(
                        size: size,
                        contentController: doctorController,
                        title: "Doctor Name",
                      ),
                    ),
                    Center(
                      child: CreateInputField(
                        size: size,
                        contentController: cityController,
                        title: "City",
                      ),
                    ),
                    Center(
                      child: CreateInputField(
                        size: size,
                        contentController: pincodeController,
                        title: "Pincode",
                      ),
                    ),
                    Center(
                      child: CreateInputField(
                        size: size,
                        contentController: amountController,
                        title: "Pension Amount",
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              Colors.blueAccent,
                              Colors.blue.shade200,
                              Colors.lightBlue.shade100
                            ]),
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 30)
                            ]),
                        child: MaterialButton(
                          onPressed: () {
                            // print(contentController.text);
                            var start = DateTime.now();
                            setState(() {
                              isLoading = true;
                            });
                            String transactionHash = "";

                            var taskBox = Hive.box('task-box');
                            taskBox.add(Task(
                                id: int.parse(panController.text),
                                name: nameController.text,
                                phone: phoneController.text,
                                aadhaar: aadhaarController.text,
                                age: int.parse(ageController.text),
                                amount: int.parse(amountController.text),
                                bank: bankController.text,
                                city: cityController.text,
                                doctor: doctorController.text,
                                ifsc: ifscController.text,
                                pan: panController.text,
                                pincode: pincodeController.text));

                            contractLinking
                                .addTask(
                                    name: nameController.text,
                                    age: int.parse(ageController.text),
                                    aadhaar: aadhaarController.text,
                                    pan: panController.text,
                                    bank: bankController.text,
                                    ifsc: ifscController.text,
                                    // branch: branchController.text,
                                    // address: addressController.text,
                                    phone: phoneController.text,
                                    doctor: doctorController.text,
                                    city: cityController.text,
                                    pincode: pincodeController.text,
                                    amount: int.parse(amountController.text))
                                .then(
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
                                          title: Text(transactionHash.isNotEmpty
                                              ? "Todo Added"
                                              : "Error"),
                                          content: Text(transactionHash
                                                  .isNotEmpty
                                              ? "Transaction Hash: $transactionHash\nTime Taken = $timeTaken"
                                              : "Error occurred in accessing blockchain"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                nameController.clear();
                                                aadhaarController.clear();
                                                ageController.clear();
                                                panController.clear();
                                                bankController.clear();
                                                ifscController.clear();
                                                // branchController.clear();
                                                // addressController.clear();
                                                phoneController.clear();
                                                doctorController.clear();
                                                cityController.clear();
                                                pincodeController.clear();
                                                amountController.clear();

                                                int count = 0;
                                                Navigator.of(context).popUntil(
                                                    (_) => count++ >= 2);
                                              },
                                              child: const Text("Ok"),
                                            )
                                          ],
                                        ));
                              },
                            );
                          },
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child:
                              const Text("Add", style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              loadingOverlay(loading: isLoading)
            ],
          )),
    );
  }
}

class CreateInputField extends StatelessWidget {
  const CreateInputField(
      {Key? key,
      required this.size,
      required this.contentController,
      required this.title})
      : super(key: key);

  final Size size;
  final TextEditingController contentController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width - 100,
        child: TextField(
          controller: contentController,
          style: const TextStyle(fontSize: 20),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter your $title",
              labelText: title),
        ),
      ),
    );
  }
}

Widget loadingOverlay({required bool loading}) {
  return loading
      ? BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
          child: const Center(
              child: SizedBox(
            height: 150,
            width: 150,
            child: CircularProgressIndicator(backgroundColor: Colors.grey),
          )),
        )
      : const SizedBox(height: 0, width: 0);
}
