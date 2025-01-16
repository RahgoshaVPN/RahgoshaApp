import 'dart:convert';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rahgosha/common/logger.dart';
import 'package:rahgosha/utils/appcache.dart';
import 'package:rahgosha/utils/locations.dart';
import 'package:rahgosha/utils/tools.dart';
import 'package:rahgosha/widgets/home/connection.dart';
import 'package:rahgosha/widgets/home/server_selection_modal.dart';
import 'package:rahgosha/common/theme.dart';
import 'package:rahgosha/widgets/home/vpn_card.dart';
import 'package:rahgosha/utils/notifiers.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool proxyOnly = false;
  List<String> bypassSubnets = [];
  String? coreVersion;
  String? versionName;
  bool isLoading = false;
  int? connectedServerDelay;
  String selectedServer = "Automatic";
  Widget selectedServerLogo = Icon(
    Icons.bolt,
    color: Colors.yellow,
    weight: 20,
  );
  String? domainName;
  bool isKilled = false;
  bool isFetchingPing = false;
  bool isUpdatingServers = false;

  var v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());

  late final FlutterV2ray flutterV2ray = FlutterV2ray(
    onStatusChanged: (status) {
      if (status.state != v2rayStatus.value.state) {
        context.read<V2RayStatusNotifier>().updateStatus(status);
      }
      v2rayStatus.value = status;
    },
  );


  @override
  void initState() {
    super.initState();

    flutterV2ray.initializeV2Ray(
      notificationIconResourceType: "mipmap",
      notificationIconResourceName: "ic_launcher_foreground",
    );

    flutterV2ray.getCoreVersion().then((version) {
      logger.debug("Core version: $version");
      cache.set("coreVersion", version);
    });

    String userChoice = getUserChoice();

    if (userChoice == "Automatic") {
      setUserChoice(selectedServer: "Automatic");
      selectedServerLogo = Icon(
        Icons.bolt,
        color: Colors.yellow,
        weight: 20,
      );
      selectedServer = "Automatic";
    } else {
      selectedServer = CountryService.getCountryName(userChoice);
      selectedServerLogo = CountryFlag.fromCountryCode(
        userChoice,
        shape: Circle(),
        width: 20,
      );
    }

    final urlNotifier = context.read<V2RayURLNotifier>();
    urlNotifier.addListener(_onV2RayURLChanged);
  }
  void _onV2RayURLChanged() async {
    final urlNotifier = context.read<V2RayURLNotifier>();
    final url = urlNotifier.url;

    await disconnectServer(); // Ensure the server disconnects first
    await Future.delayed(Duration(milliseconds: 100)); // Non-blocking delay
    connectServer(url); // Connect to the new server

    // Trigger a state update if necessary
    if (mounted) {
      setState(() {});
    }
  }


  @override
  void dispose() {
    final v2rayStatusNotifier = context.read<V2RayURLNotifier>();
    v2rayStatusNotifier.removeListener(_onV2RayURLChanged);
    super.dispose();
  }


  void checkServersAndConnect() async {
    // getting configurations from the payload stored in the database
    // by using the choice that is cached
    if (!(await flutterV2ray.requestPermission())) {
      if (mounted) {
        setState(() {
          isLoading = false;
        
        });
        return;
      }
    }

    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    bool hotConnectEnabled = await isHotConnectEnabled();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> countriesWithBetterQuality = [
      "DE",
      "FI",
    ];

    String userChoice = cache.get("userChoice");
    logger
        .debug(hotConnectEnabled && prefs.getString("hc-$userChoice") != null);
    if (hotConnectEnabled && prefs.getString("hc-$userChoice") != null) {
      String? lastServers = prefs.getString("hc-$userChoice");
      String? lastSelectedURL = prefs.getString("hc-$userChoice-url");

      if (lastSelectedURL != null) {
        connectServer(lastSelectedURL);
        return;
      }
      if (lastServers != null) {
        logger.debug("Last servers: $lastServers");
        
        Map<String, dynamic> getAllDelay = jsonDecode(lastServers);

        String bestServer = "";
        int minDelay = double.maxFinite.toInt();

        getAllDelay.forEach((server, delay) {
          if (delay != -1 && delay < minDelay) {
            logger.debug("Low delay server chosen with delay: $delay");
            logger.debug("Server: $server");
            minDelay = delay;
            bestServer = server;
          }
        });

        if (bestServer.isNotEmpty) {
          connectServer(bestServer);
          return;
        }
      }
    }

    logger.debug(cache.get("servers"));
    List<dynamic> servers = userChoice == "Automatic"
        ? [
            for (var country in countriesWithBetterQuality)
              ...cache.get("servers")["profilesByCountryCode"][country]
          ]
        : cache.get("servers")["profilesByCountryCode"][userChoice];
    // List<dynamic> servers = cache.get("servers")["profilesByCountryCode"][userChoice];
    List<String> parsedServers = [];

    for (var server in servers) {
      logger.debug(server);
      try {
        V2RayURL parsedProfile = FlutterV2ray.parseFromURL(server);
        dynamic fullConfiguration =
            jsonDecode(parsedProfile.getFullConfiguration());
        fullConfiguration["_url"] = server;
        fullConfiguration["_remark"] = parsedProfile.remark;
        parsedServers.add(jsonEncode(fullConfiguration));
      } catch (e) {
        logger.warning("Failed to parse server: $server");
      }
    }

    // checking all the servers by their delay
    // and storing them in a value

    Map<String, dynamic> getAllDelay = jsonDecode(
        await flutterV2ray.getAllServerDelay(configs: parsedServers));

    String bestServer = "";
    int minDelay = double.maxFinite.toInt();

    // saves last servers with their delay to prevent
    // checking them again if the hotConnect is enabled
    String lastServers = jsonEncode(getAllDelay);
    logger.info("Saving servers: $lastServers");
    prefs.setString("hc-$userChoice", lastServers);
    prefs.remove("hc-$userChoice-index");
    prefs.remove("hc-$userChoice-url");

    getAllDelay.forEach((server, delay) {
      if (delay != -1 && delay < minDelay) {
        logger.info("Low delay server chosen with delay: $delay");
        logger.debug("Server: $server");
        minDelay = delay;
        bestServer = server;
      }
    });

    if (bestServer.isEmpty) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      } else {
        isLoading = false;
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Failed to connect to this server"),
          action: SnackBarAction(
            label: "Retry", 
            onPressed: checkServersAndConnect,
            textColor: themeColors.primaryColor,
          )
        ));
      return;
    }

    connectServer(bestServer);
  }

  void connectServer(String url) async {
    if (await flutterV2ray.requestPermission()) {
      flutterV2ray.startV2Ray(
          remark: "Rahgosha: $selectedServer",
          // The use of parser.getFullConfiguration() is not mandatory,
          // and you can enter the desired V2Ray configuration in JSON format
          config: url,
          blockedApps: null,
          bypassSubnets: null,
          proxyOnly: false,
          notificationDisconnectButtonName: "Disconnect");
    } else {
      setState(() {
        isLoading = false;
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Permission denied"),
          action: SnackBarAction(label: "Retry", onPressed: () {})));
    }

    // await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    } else {
      isLoading = false;
    }
  }

  Future<void> disconnectServer() async {
    await flutterV2ray.stopV2Ray();
  }

  void handleServerSelection(server) {
    if (v2rayStatus.value.state == "CONNECTED") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          final textStyle = TextStyle(color: themeColors.textColor);
          return AlertDialog(
            title: Text(
              "Change Server",
              style: textStyle,
            ),
            content: Text(
              "If you change your server, you will be disconnected and reconnected. Do you want to proceed?",
              style: textStyle,
            ),
            backgroundColor: themeColors.secondaryBackgroundColor,
            actions: [
              TextButton(
                child: Text(
                  "Cancel",
                  style: textStyle,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(
                  "OK",
                  style: textStyle,
                ),
                onPressed: () {
                  disconnectServer();
                  Navigator.pop(context);
                  Future.delayed(const Duration(seconds: 1), () {
                    handleServerSelection(server);
                    setState(() {
                      isLoading = true;
                    });
                    checkServersAndConnect();
                  });
                },
              ),
            ],
          );
        },
      );
      return;
    }
    setUserChoice(selectedServer: server);
    setState(() {
      if (server != "Automatic") {
        selectedServer = CountryService.getCountryName(server);
        selectedServerLogo = CountryFlag.fromCountryCode(
          server,
          shape: Circle(),
          width: 20,
        );
      } else {
        selectedServer = server;
        selectedServerLogo = Icon(
          Icons.bolt,
          color: Colors.yellow,
        );
      }
    });
    logger.debug(context.toString());
    safePop(context);
  }

  void updateServers() {
    if (v2rayStatus.value.state == "CONNECTED") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Cannot update servers while connected.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      isUpdatingServers = true;
    });

    bool isFailed = false;

    () async {
      try {
        await reloadStorage(userChoice: getUserChoice(), forceReload: true);
        await reloadCache();
      } catch (e) {
        logger.warning("Failed to update servers");

        isFailed = true;

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Failed to update servers, Error: $e",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            action: SnackBarAction(
              label: "Retry",
              textColor: Colors.yellow,
              onPressed: updateServers,
            ),
          ),
        );
      }
    }()
        .whenComplete(() {
      setState(() {
        isUpdatingServers = false;
      });
      if (isFailed) return;

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Servers updated successfully",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Future<List<Widget>> optionsFuture = loadOptions(
      handleServerSelection,
      selectedServer,
      ["DE", "FI", "NL", "FR", "US", "CA", "GB"],
    );

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: isLoading
                      ? null
                      : () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ServerSelectionModal(
                                onServerSelected: handleServerSelection,
                                selectedServer: getUserChoice(),
                                optionsFuture: optionsFuture,
                              );
                            },
                          );
                        },
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isLoading
                          ? themeColors.secondaryBackgroundColor.withAlpha(128)
                          : themeColors.secondaryBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      // border:  Border.all(color: Colors.grey.withOpacity(0.1)),
                    ),
                    child: Row(
                      children: [
                        selectedServerLogo,
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          selectedServer.toString(),
                          style: TextStyle(
                              color: themeColors.textColor,
                              fontSize: 16,
                              fontFamily: "GM"),
                        ),
                        const Spacer(),
                        Icon(Icons.keyboard_arrow_down,
                            color: Colors.grey[400]),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: isLoading
                      ? themeColors.secondaryBackgroundColor.withAlpha(128)
                      : themeColors.secondaryBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IgnorePointer(
                  ignoring: isUpdatingServers || isLoading,
                  child: IconButton(
                    onPressed:
                        isUpdatingServers || isLoading ? null : updateServers,
                    icon: isUpdatingServers
                        ? LoadingAnimationWidget.threeArchedCircle(
                            color: themeColors.textColor,
                            size: 19,
                          )
                        : Icon(
                            Icons.refresh,
                            color: themeColors.textColor,
                          ),
                  ),
                ),
              ),
              const SizedBox(
                width: 18,
              )
            ],
          ),
          Expanded(
              child: Center(
            child: ValueListenableBuilder(
                valueListenable: v2rayStatus,
                builder: (context, value, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ConnectionWidget(
                          onTap: () {
                            if (value.state == "DISCONNECTED") {
                              if (mounted) {
                                setState(() {
                                  isLoading = true;
                                });
                              }
                              checkServersAndConnect();
                            } else {
                              disconnectServer();
                            }
                          },
                          isLoading: isLoading,
                          status: value.state),
                      if (value.state == "CONNECTED") ...[
                        const SizedBox(
                          height: 60,
                        ),
                        VpnCard(
                          download: value.download,
                          upload: value.upload,
                          downloadSpeed: value.downloadSpeed,
                          uploadSpeed: value.uploadSpeed,
                          selectedServer: selectedServer,
                          selectedServerCC: getUserChoice(),
                          duration: value.duration,
                        )
                      ]
                    ],
                  );
                }),
          ))
        ],
      )),
    );
  }
}
