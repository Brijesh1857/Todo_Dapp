import 'package:flutter/material.dart';
import 'package:todolist_blockchain/linking/metamask_linking.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MetaMaskProvider metaMaskProvider = MetaMaskProvider();
    return Scaffold(
      body: Center(
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
              print('Button pressed');
              metaMaskProvider.connect();
            },
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text("Connect", style: TextStyle(fontSize: 20)),
          ),
        ),
      ),
    );
  }
}
