import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rahgosha/logger.dart';
import 'package:rahgosha/utils/tools.dart';
import 'package:rahgosha/widgets/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ServersScreen extends StatefulWidget {
  const ServersScreen({super.key});


  @override
  State<StatefulWidget> createState() => ServersScreenState();
}

class ServersScreenState extends State<ServersScreen> with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  Future<Map<String, dynamic>?>? _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _loadOptions();
    
     final v2rayStatusNotifier = context.read<V2RayStatusNotifier>();
    v2rayStatusNotifier.addListener(_onV2RayStatusChanged);
  }

  void _onV2RayStatusChanged() => _futureData = _loadOptions();

  @override
void dispose() {
  final v2rayStatusNotifier = context.read<V2RayStatusNotifier>();
  v2rayStatusNotifier.removeListener(_onV2RayStatusChanged);
  super.dispose();
}


  Future<Map<String, dynamic>?> _loadOptions() async {
    final v2rayStatus = context.read<V2RayStatusNotifier>().v2rayStatus.value;

    if (v2rayStatus.state == "CONNECTED") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userChoice = getUserChoice();
      dynamic decodedProfiles = jsonDecode(prefs.getString("hc-$userChoice")!);

      return decodedProfiles;
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: _futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error loading servers: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              final serversWithDelay = snapshot.data!;

              final sortedServers = serversWithDelay.entries.toList()
                ..sort((a, b) => a.value.compareTo(b.value));

              final rearrangedServers = [
                ...sortedServers.where((entry) => entry.value != -1),
                ...sortedServers.where((entry) => entry.value == -1),
              ];

              return SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < rearrangedServers.length; i++) 
                      _buildProfileCard(
                        _decodeRemark(rearrangedServers[i].key),
                        i,
                        rearrangedServers[i].value,
                      ),
                  ],
                ),
              );
            } else {
              String txt = "No servers found";
              String state = context.read<V2RayStatusNotifier>()
                  .v2rayStatus.value.state;
              logger.debug(state);
              if (
                state == "DISCONNECTED") {
                txt = "$txt\nConnect the vpn first";
              }
              return Center(
                child: Text(
                  txt,
                  style: TextStyle(
                    color: themeColors.textColor,
                  ),
                  textAlign: TextAlign.center,
                )
              );
            }
          },
        ),
      ),
    );
  }


  String _decodeRemark(String jsonString) {
    try {
      final dynamic decoded = jsonDecode(jsonString);
      final String remark = decoded['_remark'] ?? 'Unknown';

      
      if (remark.length > 50) {
        return "${remark.substring(0, 50)}...";
      }
      return remark;
    } catch (e) {
      return 'Invalid Data';
    }
  }


  @override
  bool get wantKeepAlive => true;
  

  Widget _buildProfileCard(String name, int index, int delay) {
    return Card(
      elevation: 0,
      color: themeColors.backgroundColor,
      child: Row(
        children: [
            const SizedBox(width: 10,),
            Container(
              width: 5,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _selectedIndex == index ? 
                themeColors.primaryColor : themeColors.backgroundColor,
              ),
            ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  logger.debug("Index: $index");
                  _selectedIndex = index;
                });
              },

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  name,
                  style: TextStyle(
                    color: themeColors.secondaryTextColor,
                    fontSize: 16,
                    fontFamilyFallback: ["Emoji"],
                  ),
                ),
              ),
            ),
          ),
          _buildDelayIndicator(delay)
        ],
      ),
    );
  }

  Widget _buildDelayIndicator(int delay) {
    if (delay == -1) {
      return const Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: Text(
          "X",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      );
    }

    
    Color delayColor;
    if (delay < 1000) {
      delayColor = Colors.green;
    } else if (delay < 2000) {
      delayColor = Colors.yellow;
    } else {
      delayColor = Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Text(
        "$delay",
        style: TextStyle(
          color: delayColor,
          fontWeight: FontWeight.w300,
          fontSize: 12,
        ),
      ),
    );
  }


}
