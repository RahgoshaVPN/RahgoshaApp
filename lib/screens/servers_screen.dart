import 'dart:convert';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rahgosha/common/logger.dart';
import 'package:rahgosha/utils/custom_snackbar.dart';
import 'package:rahgosha/utils/tools.dart';
import 'package:rahgosha/common/theme.dart';
import 'package:rahgosha/widgets/tip_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rahgosha/utils/providers.dart';

class ServersScreen extends StatefulWidget {
  const ServersScreen({super.key});


  @override
  State<StatefulWidget> createState() => ServersScreenState();
}

class ServersScreenState extends State<ServersScreen> with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  Future<Map<String, dynamic>?>? _futureData;
  Map<String, dynamic>? _serversProfiles;
  bool isReconnecting = false;

  @override
  void initState() {
    super.initState();
    _initializeSelectedIndex();
    _futureData = _loadOptions();

    final v2rayStatusNotifier = context.read<V2RayStatusNotifier>();
    v2rayStatusNotifier.addListener(_onV2RayStatusChanged);
  }

  Future<void> _initializeSelectedIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userChoice = getUserChoice();
    
    
    int savedIndex = prefs.getInt("hc-$userChoice-index") ?? 0;
    setState(() {
      _selectedIndex = savedIndex;
    });
  }

  void _onV2RayStatusChanged() => setState(() {
    _futureData = _loadOptions();
    
    _initializeSelectedIndex();
  });

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

      final sortedEntries = (decodedProfiles as Map<String, dynamic>).entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));

      final rearrangedEntries = [
        ...sortedEntries.where((entry) => entry.value != -1),
        ...sortedEntries.where((entry) => entry.value == -1),
      ];

      final sortedProfiles = Map.fromEntries(rearrangedEntries);

      _serversProfiles = sortedProfiles;

      return sortedProfiles;
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ThemeColors themeColors = context.watch<ThemeProvider>().getColors(context);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: _futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "errors.error_loading_servers".tr(
                    args: [snapshot.error.toString()]
                  )
                )
              );
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    if (areTipsEnabled()) ...[
                      TipWidget(text: "tips.hold_to_copy".tr())
                    ],
                    for (int i = 0; i < _serversProfiles!.length; i++) 
                      _buildProfileCard(
                        _decodeRemark(_serversProfiles!.keys.elementAt(i)),
                        i,
                        _serversProfiles!.values.elementAt(i),
                      ),
                  ],
                ),
              );
            } else {
              String txt = "screens.servers.no_servers_found".tr();
              String state = context.read<V2RayStatusNotifier>()
                  .v2rayStatus.value.state;
              logger.debug(state);
              if (
                state == "DISCONNECTED") {
                txt = "$txt\n${"screens.servers.connect_vpn_first".tr()}";
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
      // logger.debug(decoded["_remark"]);
      final String remark = decoded['_remark'] ?? "general.unknown".tr();

      
      if (remark.length > 50) {
        return "${remark.substring(0, 50)}...";
      }
      return remark;
    } catch (e) {
      return "screens.servers.invalid_data".tr();
    }
  }


  @override
  bool get wantKeepAlive => true;
  
  Widget _buildProfileCard(String name, int index, int delay) {
    final ThemeColors themeColors = context.watch<ThemeProvider>().getColors(context);
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Card(
        elevation: 0,
        color: themeColors.backgroundColor,
        child: Row(
          children: [
            const SizedBox(width: 10),
            Container(
              width: 5,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _selectedIndex == index
                    ? themeColors.enabledColor
                    : themeColors.backgroundColor,
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: _selectedIndex == index
                    ? null
                    : () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String userChoice = getUserChoice();
                        prefs.setInt("hc-$userChoice-index", index);

                        final selectedKey =
                            _serversProfiles?.keys.elementAt(index);
                        if (selectedKey != null) {
                          // ignore: use_build_context_synchronously
                          final urlNotifier = context.read<V2RayURLNotifier>();
                          prefs.setString("hc-$userChoice-url", selectedKey);
                          urlNotifier.updateURL(selectedKey.toString());
                          logger.debug("Selected key: $selectedKey");
                          logger.debug(
                              "Selected Profile : ${jsonDecode(selectedKey)["_remark"]}");
                        }

                        setState(() {
                          logger.debug("Index: $index");
                          _selectedIndex = index;
                        });
                      },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: themeColors.secondaryTextColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                onLongPress: () {
                  final selectedKey =
                      _serversProfiles?.keys.elementAt(index);
                  if (selectedKey != null) {
                    // ignore: use_build_context_synchronously
                    dynamic decodedProfile = jsonDecode(selectedKey);
                    String remark = decodedProfile["_remark"];
                    if (remark.length > 50) {
                      remark = "${remark.substring(0, 50)}...";
                    }
                    Clipboard.setData(
                      ClipboardData(text: decodedProfile["_url"])
                    );


                    CustomSnackBar.show(
                      // ignore: use_build_context_synchronously
                      context, 
                      "general.copied_message".tr(
                        args: ["${"general.profile".tr()} \"$remark\""]
                      ), 
                      SnackBarType.info
                    );

                    logger.debug(
                      "Copied Profile : ${jsonDecode(selectedKey)["_remark"]}");
                  }
                },
              ),
            ),
            _buildDelayIndicator(delay),
          ],
        ),
      ),
    );
  }

  Widget _buildDelayIndicator(int delay) {
    if (delay == -1) {
      return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Text(
            "X",
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    Color delayColor;
    if (delay < 2000) {
      delayColor = Colors.green;
    } else if (delay < 3000) {
      delayColor = Colors.amber;
    } else {
      delayColor = Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Text(
          localizeNumber(delay),
          style: TextStyle(
            color: delayColor,
            fontWeight: FontWeight.w300,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
