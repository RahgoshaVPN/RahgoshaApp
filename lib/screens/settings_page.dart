import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rahgosha/widgets/languages.dart';
import 'package:rahgosha/widgets/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = false;
  bool _hotConnectEnabled = false;
  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
    _loadSettings();
  }

  void _loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedLanguage = prefs.getString('selectedLanguage') ?? 'English';
    setState(() {});
  }

  void _loadSettings() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? false;
    _hotConnectEnabled = prefs.getBool('hotConnectEnabled') ?? false;
    setState(() {});
  }

  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', _notificationsEnabled);
    await prefs.setBool('hotConnectEnabled', _hotConnectEnabled);
  }



  @override
  Widget build(BuildContext context) {

    final defaultTextStyle = TextStyle(
      color: themeColors.textColor,
      fontWeight: FontWeight.w500,
      fontSize: 13,
    );

    return Scaffold(
      backgroundColor: themeColors.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: themeColors.secondaryTextColor,
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: themeColors.secondaryTextColor,
          ),
        ),
        backgroundColor: themeColors.secondaryBackgroundColor,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "Blocked Apps",
              style: defaultTextStyle,
            ),
            subtitle: Text(
              "Manage blocked apps",
              style: TextStyle(
                color: themeColors.secondaryTextColor,
              ),
            ),
            leading: Icon(Icons.block),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Language",
              style: defaultTextStyle,
            ),
            subtitle: Text(
              "Change the app language",
              style: TextStyle(
                color: themeColors.secondaryTextColor,
              ),
            ),
            leading: Icon(Icons.language),
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => LanguageWidget(
                    selectedLanguage: _selectedLanguage!,
                  ),
                ),
              )
              .then((value) {
                _loadSelectedLanguage();
              });
            },
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.7,
          ),
          SwitchListTile(
            title: Text(
              "Enable Notifications",
              style: defaultTextStyle,
            ),
            secondary: Icon(FontAwesomeIcons.bell),
            subtitle: Text(
              "Get notified when a server is available",
              style: TextStyle(
                color: themeColors.secondaryTextColor,
              ),
            ),
            // thumbColor: WidgetStateProperty.all(themeColors.primaryColor),
            inactiveThumbColor: themeColors.primaryColor,
            activeColor: themeColors.primaryColor,
            activeTrackColor: themeColors.primaryColor.withAlpha(25),
            inactiveTrackColor: Colors.grey.shade700.withAlpha(70),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
              _saveSettings();
              
            },
          ),
          SwitchListTile(
            title: Text(
              "Enable Hot Connect",
              style: defaultTextStyle,
            ),
            subtitle: Text(
              "Caches servers with the lowest delays so you can connect faster",
              style: TextStyle(
                color: themeColors.secondaryTextColor,
              ),
            ),
            secondary: Icon(FontAwesomeIcons.fire),
            inactiveThumbColor: themeColors.primaryColor,
            activeColor: themeColors.primaryColor,
            activeTrackColor: themeColors.primaryColor.withAlpha(25),
            inactiveTrackColor: Colors.grey.shade700.withAlpha(70),
            value: _hotConnectEnabled,
            onChanged: (value) {
              setState(() {
                _hotConnectEnabled = value;
              });
              _saveSettings();
            },
          ),
          
        ],
      ),
    );
  }
}
