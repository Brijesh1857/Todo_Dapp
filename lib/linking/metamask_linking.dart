import 'package:flutter/material.dart';
import 'package:flutter_web3/ethereum.dart';

class MetaMaskProvider extends ChangeNotifier {
  static const connectingField = 0;
  String currentAddress = '';
  var account = "";
  int? currentChain;

  bool get isEnabled => ethereum != null;
  bool get isInOperatingChain => currentChain == connectingField;
  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  Future connect() async {
    print("heheheheheh");
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      account = accs[0];
      if (accs.isNotEmpty) currentAddress = accs.first;
      currentChain = await ethereum!.getChainId();
      print(account);
      print(currentChain);
      print("done");
      notifyListeners();
    } else {
      print(isConnected);
      print("hehehe");
    }
  }
}
