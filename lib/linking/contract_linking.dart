// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://127.0.0.1:8545";
  final String _wsUrl = "ws://127.0.0.1:8545/";
  final String _privateKey =
      "0x1d195bb5be73dffafe64674c5a57ffd0b0edfacf4221b461500ba68042040557";

  late Web3Client _client;
  List<Task> todos = [];
  bool isLoading = true;
  late String _abiCode;

  late EthereumAddress _contractAddress;
  late Credentials _credentials;
  late DeployedContract _contract;
  late ContractFunction _addTask;
  late ContractFunction _markDone;
  late ContractFunction _getTask;
  late ContractFunction _getTaskCount;
  late ContractFunction _deleteTodo;

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    _client = Web3Client(_rpcUrl, http.Client());

    await getAbi();
    await getCredentials();
    await getDeployedContracts();
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/artifacts/TodoList.json");

    var jsonAbi = jsonDecode(abiStringFile);

    _abiCode = jsonEncode(jsonAbi["abi"]);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
    _contractAddress =
        EthereumAddress.fromHex("0xf2a23cA848F4B0702d45f6150099CFb68b585B63");
  }

  Future<void> getDeployedContracts() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, 'TodoList'), _contractAddress);

    _getTaskCount = _contract.function('getTaskCount');
    _addTask = _contract.function('addTask');
    _markDone = _contract.function('markDone');
    _getTask = _contract.function('getTask');
    _deleteTodo = _contract.function('deleteTask');
    // getTodos();
  }

  Future<bool> getTodos() async {
    isLoading = true;
    todos.clear();
    List<dynamic> taskList = [];
    notifyListeners();

    try {
      taskList = await _client
          .call(contract: _contract, function: _getTaskCount, params: const []);
    } catch (e) {
      print(e);
      return false;
    }

    int taskCount = 0;
    taskCount = taskList[0].toInt();
    taskList.clear();
    // print(taskCount);
    for (int i = 1; i <= taskCount; i++) {
      List<dynamic> eachTask;
      // try {
      eachTask = await _client.call(
          contract: _contract, function: _getTask, params: [BigInt.from(i)]);
      // print(eachTask);
      todos.add(
        Task(
            id: eachTask[0][0].toInt(),
            name: eachTask[0][1],
            aadhaar: eachTask[0][2],
            pan: eachTask[0][3],
            bank: eachTask[0][4],
            ifsc: eachTask[0][5],
            // branch: eachTask[0][6],
            // address: eachTask[0][7],
            phone: eachTask[0][6],
            doctor: eachTask[0][7],
            city: eachTask[0][8],
            pincode: eachTask[0][9],
            age: eachTask[0][10].toInt(),
            amount: eachTask[0][11].toInt()),
      );
      // } catch (e) {
      //   print("Error = $e"); // Invalid argument: Invalid typed array length: 32
      //   return false;
      // }
    }
    isLoading = false;
    // notifyListeners();
    return true;
  }

  Future<String> addTask(
      {required String name,
      required String phone,
      // required address,
      required String aadhaar,
      required int age,
      required int amount,
      required String bank,
      // required branch,
      required String city,
      required String doctor,
      required String ifsc,
      required String pan,
      required String pincode}) async {
    isLoading = true;
    notifyListeners();
    String transactionHash = "";
    try {
      transactionHash = await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
          contract: _contract,
          function: _addTask,
          parameters: [
            name,
            aadhaar,
            pan,
            bank,
            ifsc,
            phone,
            doctor,
            city,
            pincode,
            BigInt.from(age),
            BigInt.from(amount)
          ],
          maxGas: 1000000,
        ),
        chainId: 1337,
      );
    } catch (e) {
      print("Error-11---: $e");
      print(""" Name = $name,
          adhar = $aadhaar,
          pan = $pan,
          bank = $bank,
          ifsc = $ifsc,
          phone = $phone,
          doctor = $doctor,
          city = $city,
          pindeo = $pincode,
          age = $age,
          amount = $amount""");
    }
    isLoading = false;
    return transactionHash;
    // getTodos();
  }

  Future<String> markDone(int id) async {
    isLoading = true;
    notifyListeners();
    String transactionHash = "";
    transactionHash = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _markDone,
        parameters: [BigInt.from(id)],
      ),
      chainId: 1337,
    );
    return transactionHash;
  }

  Future<String> deleteTodo(int id) async {
    isLoading = true;
    notifyListeners();
    String transactionHash = "";

    transactionHash = await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
          contract: _contract,
          function: _deleteTodo,
          parameters: [BigInt.from(id)],
        ),
        chainId: 1337);
    return transactionHash;
  }

  Future<void> sendTransactions() async{

    // TODO: PERFORM TRANSACTION HERE

    var taskBox = Hive.box('task-box');

    for(int i = 0; i < taskBox.length; i++){
      Task t = taskBox.getAt(i);
      // task is stored in temporary variabe t.
    }

    taskBox.clear();

  }
}

class Task {
  int id;
  String name;
  String aadhaar;
  String pan;
  String bank;
  String ifsc;
  // String branch;
  // String address;
  String phone;
  String doctor;
  String city;
  String pincode;
  int age;
  int amount;
  Task(
      {required this.id,
      required this.name,
      required this.phone,
      // required this.address,
      required this.aadhaar,
      required this.age,
      required this.amount,
      required this.bank,
      // required this.branch,
      required this.city,
      required this.doctor,
      required this.ifsc,
      required this.pan,
      required this.pincode});
}
