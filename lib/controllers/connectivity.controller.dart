import 'dart:io';

import 'package:Pesquisei/view-models/sincronize.viewmodel.dart';

class ConnectivityController {
  Future<bool> isConnected(SincronizeViewModel vm) async {
    try {
      vm.busy = true;
      var result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
