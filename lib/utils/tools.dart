import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_v2ray/model/v2ray_status.dart';
import 'package:rahgosha/logger.dart';
import 'package:rahgosha/utils/appcache.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> fetchServers() async {
  final url = Uri.parse("https://raw.githubusercontent.com/RahgoshaVPN/Rahgosha-Proxies/refs/heads/master/data.json");
  
  
  final client = HttpClient();

  final request = await client.getUrl(url);
  final response = await request.close();
  final statusCode = response.statusCode;

  if (statusCode == 200) {
    
    final responseBody = await response.transform(utf8.decoder).join();

    
    final Map<String, dynamic> data = jsonDecode(responseBody);

    return data;
  }

  throw Exception("Request failed with status code: $statusCode");

}



Future<bool> isPassedOneHour() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int savedTimeStamp = prefs.getInt("lastUpdate") ?? 1;

  DateTime savedTime = DateTime.fromMillisecondsSinceEpoch(savedTimeStamp);
  DateTime currentTime = DateTime.now();
  Duration difference = currentTime.difference(savedTime);

  return difference.inHours >= 1;
}

Future<void> reloadStorage({required  userChoice, bool forceReload = false}) async {
  if (!forceReload && !(await isPassedOneHour())) {
    return;
  }

  clearHotConnectCache();

  Map<String, dynamic> servers = await fetchServers();
  userChoice = servers["profilesByCountryCode"].containsKey(userChoice) ? userChoice : "Automatic";

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("servers", jsonEncode(servers));
  logger.debug("userChoice on set: $userChoice");
  await prefs.setString("userChoice", userChoice);
  await prefs.setInt("lastUpdate", DateTime.now().millisecondsSinceEpoch);

  logger.debug("reloaded storage");
}

Future<void> reloadCache() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  String? servers = prefs.getString("servers");
  if (servers != null) {
    cache.set("servers", jsonDecode(servers));
  }

  cache.set(
    "userChoice",
    prefs.getString("userChoice") ?? "Automatic"
  );

  logger.debug("reloaded cache");
  logger.debug("Choice: ${cache.get("userChoice")}");
}

void setUserChoice({required String selectedServer}) async {
  cache.set("userChoice", selectedServer);
  logger.debug("Setting user choice: $selectedServer");

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("userChoice", selectedServer);

}

String getUserChoice() => cache.get("userChoice") ?? "Automatic";

void safePop(context) {
  if (Navigator.canPop(context)) Navigator.pop(context);
}

Future<bool> isHotConnectEnabled() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("hotConnectEnabled") ?? false;
}

void clearHotConnectCache() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  for (String key in prefs.getKeys()) {
    if (key.startsWith("hc")) {
      logger.debug("removing key: $key");
      prefs.remove(key);
    }
  }
}

class V2RayStatusNotifier extends ChangeNotifier {
  final ValueNotifier<V2RayStatus> v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());

  void updateStatus(V2RayStatus status) {
    v2rayStatus.value = status;
    notifyListeners();
  }
}