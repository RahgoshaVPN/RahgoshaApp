import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rahgosha/screens/donate_screen.dart';
import 'package:rahgosha/screens/settings_page.dart';
import 'package:rahgosha/utils/appcache.dart';
import 'package:rahgosha/common/theme.dart';
import 'package:rahgosha/utils/providers.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  
  @override
  Widget build(BuildContext context) {

    final ThemeColors themeColors = context.watch<ThemeProvider>().getColors(context);
    final defaultTextStyle = TextStyle(
      color: themeColors.textColor,
      fontWeight: FontWeight.w500,
      fontSize: 13,
    );
    return Drawer(
      backgroundColor: themeColors.secondaryBackgroundColor,
      width: 240,
      elevation: 0,
      child: Column(
        children: <Widget>[          
          Expanded(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/rahgosha-banner.jpg"),
                      fit: BoxFit.cover
                    ),
                    color: themeColors.backgroundColor,
                  ),
                  
                  child: Text(''),
                ),
                ListTile(
                  title: Text(
                    "drawer.get_telegram_proxy".tr(),
                    style: defaultTextStyle,
                  ),
                  leading: Icon(
                    FontAwesomeIcons.telegram,
                    color: themeColors.textColor,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    "drawer.get_free_config".tr(),
                    style: defaultTextStyle,
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.cloudArrowDown,
                    color: themeColors.textColor,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Divider(
                  color: Colors.grey.shade800,
                  thickness: 0.7,
                ),
                ListTile(
                  title: Text(
                    "drawer.settings".tr(),
                    style: defaultTextStyle,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SettingsPage())
                    );
                  },
                  leading: Icon(
                    Icons.settings,
                    color: themeColors.textColor,
                  ),
                ),
                ListTile(
                  title: Text(
                    "drawer.about".tr(),
                    style: defaultTextStyle,
                  ),
                  leading: Icon(
                    Icons.info,
                    color: themeColors.textColor,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    "drawer.logs".tr(),
                    style: defaultTextStyle,
                  ),
                  leading: Icon(
                    Icons.bug_report,
                    color: themeColors.textColor,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },

                ),
                ListTile(
                  title: Text(
                    "drawer.donate".tr(),
                    style: defaultTextStyle,
                    
                  ),
                  leading: Icon(
                    FontAwesomeIcons.handHoldingDollar,
                    color: themeColors.textColor,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => DonateScreen())
                    );
                  },
                )
              ],
            ),
          ),
          
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "v${cache.get("version")} (${cache.get("coreVersion")})", 
              style: TextStyle(
                color: themeColors.secondaryTextColor,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}