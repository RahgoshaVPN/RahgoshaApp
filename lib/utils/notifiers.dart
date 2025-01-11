import 'package:flutter/material.dart';
import 'package:flutter_v2ray/model/v2ray_status.dart';


class V2RayStatusNotifier extends ChangeNotifier {
  final ValueNotifier<V2RayStatus> v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());

  void updateStatus(V2RayStatus status) {
    v2rayStatus.value = status;
    notifyListeners();
  }
}

class V2RayURLNotifier extends ChangeNotifier {
  dynamic url;

  void updateURL(String newUrl) {
    url = newUrl;
    notifyListeners();
  }
}