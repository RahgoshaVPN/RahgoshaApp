import 'dart:convert';
import 'dart:io';

import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rahgosha/common/logger.dart';
import 'package:rahgosha/common/theme.dart';
import 'package:rahgosha/utils/providers.dart';

class VpnCard extends StatefulWidget {
  final int downloadSpeed;
  final int uploadSpeed;
  final String selectedServer;
  final String selectedServerCC;
  final String duration;

  final int download;
  final int upload;

  const VpnCard(
      {super.key,
      required this.downloadSpeed,
      required this.uploadSpeed,
      required this.download,
      required this.upload,
      required this.selectedServer,
      required this.selectedServerCC,
      required this.duration});

  @override
  State<VpnCard> createState() => _VpnCardState();
}

class _VpnCardState extends State<VpnCard> {
  String? ipText;
  String? ipflag;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = context.watch<ThemeProvider>().getColors(context);
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Positioned(
          top: -30,
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: themeColors.secondaryBackgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.withAlpha(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  widget.duration,
                  style: TextStyle(
                    color: themeColors.textColor,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 350,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: themeColors.secondaryBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey.withAlpha(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 12),
                  widget.selectedServerCC != "Automatic" ? 
                  CountryFlag.fromCountryCode(
                    widget.selectedServerCC,
                    width: 40,
                    shape: Circle(),
                    ) : 
                  Icon(
                    Icons.bolt,
                    // color: themeColors.primaryColor,
                    color: Colors.amber,
                    size: 40,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.selectedServer,
                        style: TextStyle(
                          color: themeColors.textColor,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      _buildIpButton(),
                    ],
                  ),
                ],
              ),
              Divider(color: Colors.grey.withAlpha(25)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatColumn(
                      icon: Icons.data_usage_rounded,
                      download: formatBytes(widget.downloadSpeed),
                      upload: formatBytes(widget.uploadSpeed),
                      status: "screens.home.vpn_card.real_time_usage".tr(),
                    ),
                    _buildStatColumn(
                      icon: Icons.wifi_rounded,
                      download: formatSpeedBytes(widget.download),
                      upload: formatSpeedBytes(widget.upload),
                      status: "screens.home.vpn_card.total_usage".tr(),

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String formatBytes(int bytes) {
    if (bytes <= 0) return '0Byte';

    const int kb = 1024;
    const int mb = kb * 1024;
    const int gb = mb * 1024;

    if (bytes < kb) return '$bytes Byte${bytes > 1 ? 's' : ''}';
    if (bytes < mb) return '${(bytes / kb).toStringAsFixed(2)}KB';
    if (bytes < gb) return '${(bytes / mb).toStringAsFixed(2)}MB';
    return '${(bytes / gb).toStringAsFixed(2)}GB';
  }

  String formatSpeedBytes(int bytes) {
    if (bytes <= 0) return '0byte/s';

    const int kb = 1024;
    const int mb = kb * 1024;
    const int gb = mb * 1024;

    if (bytes < kb) return '${bytes}byte/s';
    if (bytes < mb) return '${(bytes / kb).toStringAsFixed(2)}KB/s';
    if (bytes < gb) return '${(bytes / mb).toStringAsFixed(2)}MB/s';
    return '${(bytes / gb).toStringAsFixed(2)}GB/s';
  }

  Widget _buildIpButton() {
    final ThemeColors themeColors = context.watch<ThemeProvider>().getColors(context);
    return Container(
      decoration: BoxDecoration(
        color: themeColors.backgroundColor.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withAlpha(25),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            setState(() => isLoading = true);
            final ipInfo = await getIpApi();
            try {
              setState(() {
                if (ipInfo['countryCode'] == 'Error') {
                  ipflag = null;
                  ipText = "general.unknown".tr();
                  isLoading = false;
                  return;
                }
                ipflag = countryCodeToFlagEmoji(ipInfo['countryCode']!);
                ipText = ipInfo['ip'];
                if (ipInfo['ip']!.contains(':')) {
                  ipText = ipInfo['ip']!.length > 12
                    ? '${ipInfo['ip']!.substring(0, 12)}...'
                    : ipInfo['ip'];
                } else {
                  ipText = ipInfo['ip'];
                }
                isLoading = false;
                Future.delayed(Duration(seconds: 4), () {
                  try {
                    setState(() {
                      ipText = "screens.home.vpn_card.show_ip_address";
                      ipflag = null;
                    });
                  } catch (e) {
                    logger.warning('Error setting IP info: $e');
                  }
                });
              });
            } catch (e) {
              logger.warning('Error setting IP info: $e');
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.grey[400]),
                    ),
                  )
                else ...[
                  Text(
                    (ipText ?? "screens.home.vpn_card.show_ip_address").tr(),
                    overflow: TextOverflow.ellipsis, 
                    maxLines: 1, 
                    softWrap: false, 
                    style: TextStyle(
                      color: themeColors.textColor,
                      fontSize: 13,
                    ),
                  ),
                  if (ipflag != null) ...[
                    SizedBox(width: 6),
                    Text(
                      ipflag!,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn({
    required IconData icon,
    required String download,
    required String upload,
    required String status,
  }) {
    final ThemeColors themeColors = context.watch<ThemeProvider>().getColors(context);
    return Row(
      children: [
        Icon(
          icon,
          color: themeColors.enabledColor,
          size: 20,
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              status,
              style: TextStyle(
                fontSize: 12,
                color: themeColors.textColor
              ),
              
            ),
            SizedBox(height: 4),
            Text(
              "⬇️ $download",
              style: TextStyle(
                color: themeColors.textColor,
                fontSize: 13,
              ),
            ),
            Text(
              "⬆️ $upload",
              style: TextStyle(
                color: themeColors.textColor,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

String countryCodeToFlagEmoji(String countryCode) {
  countryCode = countryCode.toUpperCase();
  final flag = countryCode.codeUnits
      .map((codeUnit) => String.fromCharCode(0x1F1E6 + codeUnit - 0x41))
      .join();

  return Text(
        flag,
        style: const TextStyle(
          fontSize: 16,
        ),
      ).data ??
      flag;
}

Future<Map<String, String>> getIpApi() async {
  try {
    final url = Uri.parse('https://freeipapi.com/api/json');
    final httpClient = HttpClient();
    final request = await httpClient.getUrl(url);
    request.headers.set('X-Content-Type-Options', 'nosniff');
    final response = await request.close();

    if (response.statusCode == 200) {
      final responseBody = await response.transform(utf8.decoder).join();
      final data = jsonDecode(responseBody);

      if (data != null && data is Map) {
        String ip = data['ipAddress'] ?? 'Unknown IP';

        return {'countryCode': data['countryCode'] ?? 'Unknown', 'ip': ip};
      }
    }

    return {'countryCode': 'Unknown', 'ip': 'Unknown IP'};
  } catch (e) {
    return {'countryCode': 'Error', 'ip': 'Error'};
  }
}
