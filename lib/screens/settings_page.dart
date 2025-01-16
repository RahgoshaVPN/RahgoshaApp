import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rahgosha/widgets/settings/blocked_apps_widget.dart';
import 'package:rahgosha/widgets/settings/languages_widget.dart';
import 'package:rahgosha/common/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _autoUpdateEnabled = true;
  bool _hotConnectEnabled = true;
  double _updateInterval = 1.0;
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
    _updateInterval = prefs.getDouble("updateInterval") ?? 1.0;
    setState(() {});
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _autoUpdateEnabled = prefs.getBool('autoUpdateEnabled') ?? true;
    _hotConnectEnabled = prefs.getBool('hotConnectEnabled') ?? true;
    setState(() {});
  }

  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('autoUpdateEnabled', _autoUpdateEnabled);
    await prefs.setBool('hotConnectEnabled', _hotConnectEnabled);
    await prefs.setDouble("updateInterval", _updateInterval);
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
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => BlockedAppsWidgets())
              );
            },
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  SwitchListTile(
                    title: Text(
                      "Enable Auto Update",
                      style: defaultTextStyle,
                    ),
                    secondary: Icon(FontAwesomeIcons.rotateRight),
                    subtitle: Text(
                      "Update servers when you open the app",
                      style: TextStyle(
                        color: themeColors.secondaryTextColor,
                      ),
                    ),
                    inactiveThumbColor: themeColors.primaryColor,
                    activeColor: themeColors.primaryColor,
                    activeTrackColor: themeColors.primaryColor.withAlpha(25),
                    inactiveTrackColor: Colors.grey.shade700.withAlpha(70),
                    value: _autoUpdateEnabled,
                    onChanged: (value) {
                      setState(() {
                        _autoUpdateEnabled = value;
                      });
                      _saveSettings();
                    },
                  ),
              if (_autoUpdateEnabled)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 20,),
                          Text(
                            "Select update interval (in hours):",
                            style: TextStyle(
                              color: themeColors.secondaryTextColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                          valueIndicatorTextStyle: TextStyle(
                            color: Colors.black87,
                          )
                        ), 
                          child: Slider(
                            value: _updateInterval,
                            min: 1,
                            max: 24,
                            divisions: 23,
                            activeColor: themeColors.primaryColor,
                            label: "${_updateInterval.toInt()} hours",
                            onChanged: (value) {
                              setState(() {
                                _updateInterval = value;
                                _saveSettings();
                              });
                            },
                            inactiveColor: themeColors.primaryColor.withAlpha(25),
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
