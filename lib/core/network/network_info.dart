import 'dart:io';


abstract class NetworkInfo {
  Future<bool> get isConnected;
}

// class NetworkInfoImplPackage implements NetworkInfo {
//   final DataConnectionChecker dataConnectionChecker;
//
//   NetworkInfoImplPackage(this.dataConnectionChecker);
//
//   @override
//   Future<bool> get isConnected async =>
//       await dataConnectionChecker.hasConnection;
// }

class NetworkInfoImplCustom extends NetworkInfo {
  Future<bool> checkConnectionWithInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print("connected ");
        return true;
      }
    } on SocketException catch (_) {
      //   print("Not connected ");
      return false;
    }
    return false;
  }

  @override
  // TODO: implement isConnected
  Future<bool> get isConnected async => await checkConnectionWithInternet();
}
