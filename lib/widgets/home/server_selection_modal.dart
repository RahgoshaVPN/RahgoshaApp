import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:rahgosha/common/logger.dart';
import 'package:rahgosha/utils/appcache.dart';
import 'package:rahgosha/utils/tools.dart';
import 'package:rahgosha/common/theme.dart';

class ServerSelectionModal extends StatelessWidget {
  final String selectedServer;
  final Function(String) onServerSelected;
  final Future<List<Widget>> optionsFuture;

  const ServerSelectionModal({
    super.key,
    required this.selectedServer,
    required this.onServerSelected,
    required this.optionsFuture,
  });

  @override
  Widget build(BuildContext context) {
    logger.debug("Selected server: $selectedServer");
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: themeColors.secondaryBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.public,
                  color: themeColors.textColor,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  "screens.home.server_selection.title".tr(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeColors.textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(
                Icons.bolt,
                color: Colors.yellow,
              ),
              title: Text(
                'general.automatic'.tr(),
                style: TextStyle(
                  color: themeColors.textColor,
                ),
              ),
              trailing: selectedServer == 'Automatic'
                  ? Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () => onServerSelected('Automatic'),
            ),
            SizedBox(height: 15),
            FutureBuilder<List<Widget>>(
              future: optionsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("errors.error".tr(
                    args: [snapshot.error.toString()]
                  ));
                } else if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data!,
                  );
                } else {
                  return Text("screens.home.server_selection.no_data".tr());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Widget>> loadOptions(
  Function(String) onTap,
  String selectedServer,
  List<String> recommendedServers,
) async {
  Map<String, dynamic> jsonData = cache.get("servers") ?? await fetchServers();
  List<String> countryCodes = List<String>.from(jsonData["locations"]["byCountryCode"]);

  List<Widget> options = [];

  if (recommendedServers.isNotEmpty) {
    options.add(
      Row(
        children: [
          Text(
            "screens.home.server_selection.recommended".tr(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: themeColors.textColor,
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 1,
              indent: 10,
            ),
          ),
        ],
      ),
    );

    for (String countryCode in recommendedServers) {
      if (!countryCodes.contains(countryCode)) continue;

      logger.debug("Selected Server: $selectedServer, CountryCode: $countryCode");

      final String countryName = "locations.$countryCode".tr();
      options.add(
        ListTile(
          title: Text(
            countryName,
            style: TextStyle(color: themeColors.textColor),
          ),
          onTap: () => onTap(countryCode),
          leading: CountryFlag.fromCountryCode(
            countryCode,
            width: 20,
            shape: const Circle(),
          ),
          trailing: selectedServer == countryCode
              ? Icon(Icons.check, color: Colors.green)
              : null,
        ),
      );
    }
    options.add(SizedBox(height: 20));
  }

  options.add(
    Row(
      children: [
        Text(
          "screens.home.server_selection.all_servers".tr(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: themeColors.textColor,
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            indent: 10,
          ),
        ),
      ],
    ),
  );

  for (String countryCode in countryCodes) {
    final String countryName = "locations.$countryCode".tr();
      // logger.debug(countryName);
      // logger.debug(selectedServer);
      // logger.debug(selectedServer == countryName);
    options.add(
      ListTile(
        title: Text(
          countryName,
          style: TextStyle(color: themeColors.textColor),
        ),
        onTap: () => onTap(countryCode),
        leading: CountryFlag.fromCountryCode(
          countryCode,
          width: 20,
          shape: const Circle(),
        ),
        trailing: selectedServer == countryCode
            ? Icon(Icons.check, color: Colors.green)
            : null,
      ),
    );
  }

  cache.set("servers", jsonData);
  return options;
}
