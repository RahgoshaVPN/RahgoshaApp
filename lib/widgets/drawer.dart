import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rahgosha/screens/settings_page.dart';
import 'package:rahgosha/utils/appcache.dart';
import 'package:rahgosha/widgets/theme.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  
  @override
  Widget build(BuildContext context) {

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
                    'Get Telegram Proxy',
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
                    "Get Free Config",
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
                    'Settings',
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
                    "About",
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
                    "Logs",
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
              ],
            ),
          ),
          
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${cache.get("version")} (${cache.get("coreVersion")})", 
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