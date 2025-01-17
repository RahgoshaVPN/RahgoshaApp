import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rahgosha/common/logger.dart';
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



Future<bool> hasTimePassed(double updateInterval) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int savedTimeStamp = prefs.getInt("lastUpdate") ?? 1;

  DateTime savedTime = DateTime.fromMillisecondsSinceEpoch(savedTimeStamp);
  DateTime currentTime = DateTime.now();
  Duration difference = currentTime.difference(savedTime);

  return difference.inHours >= updateInterval;
}


Future<void> reloadStorage({required  userChoice, bool forceReload = false}) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  double updateInterval = prefs.getDouble("updateInterval") ?? 1;

  if (!forceReload && !(await hasTimePassed(updateInterval))) {
    return;
  }

  clearHotConnectCache();

  Map<String, dynamic> servers = await fetchServers();
  userChoice = servers["profilesByCountryCode"].containsKey(userChoice) ? userChoice : "Automatic";

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
  return prefs.getBool("hotConnectEnabled") ?? true;
}

void clearHotConnectCache() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  for (String key in prefs.getKeys()) {
      logger.debug(key);
    if (key.startsWith("hc")) {
      logger.debug("removing key: $key");
      prefs.remove(key);
      prefs.remove("$key-index");
    }
  }
}


String localizeNumber(dynamic number) {
  final numberString = number.toString(); 
  final translatedDigits = numberString.split('').map((digit) {
    final localizedDigit = 'numbers.$digit'.tr();
    return localizedDigit == 'numbers.$digit' ? digit : localizedDigit;
  }).join('');
  return translatedDigits;
}