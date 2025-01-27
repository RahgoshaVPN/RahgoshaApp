import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rahgosha/common/logger.dart';
import 'package:rahgosha/utils/appcache.dart';
import 'package:rahgosha/utils/providers.dart';
import 'package:rahgosha/utils/tools.dart';
import 'package:rahgosha/widgets/selectable_dialog_widget.dart';
import 'package:rahgosha/widgets/settings/blocked_apps_widget.dart';
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
  bool _tipsEnabled = true;
  double _updateInterval = 1.0;
  String? _selectedLanguage;
  String _appTheme = "system";

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
    _tipsEnabled = prefs.getBool('tipsEnabled') ?? true;
    _appTheme = prefs.getString("appTheme") ?? "system";
    setState(() {});
  }

  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('autoUpdateEnabled', _autoUpdateEnabled);
    await prefs.setBool('hotConnectEnabled', _hotConnectEnabled);
    await prefs.setBool("tipsEnabled", _tipsEnabled);
    await prefs.setDouble("updateInterval", _updateInterval);
    await prefs.setString("appTheme", _appTheme);
    cache.set("appTheme", _appTheme);
    cache.set("tipsEnabled", _tipsEnabled);
  }



  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = context.watch<ThemeProvider>().getColors(context);

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
          "screens.settings.common.settings".tr(),
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
              "screens.settings.app_theme.title".tr(),
              style: defaultTextStyle,
            ),
            subtitle: Text(
              "screens.settings.app_theme.subtitle".tr(),
              style: TextStyle(
                color: themeColors.secondaryTextColor,
              ),
            ),
            leading: Icon(Icons.palette),
            onTap: () => showDialog(
              context: context, 
              builder: (context) => SelectableDialog(
                titleKey: "screens.settings.app_theme.select_theme", 
                items: [
                  _buildThemeTile(context, "system", themeColors),
                  _buildThemeTile(context, "light", themeColors),
                  _buildThemeTile(context, "dark", themeColors),
                  _buildThemeTile(context, "black", themeColors),
                ]
              ),
            )
          ),
          ListTile(
            title: Text(
              "screens.settings.blocked_apps.title".tr(),
              style: defaultTextStyle,
            ),
            subtitle: Text(
              "screens.settings.blocked_apps.subtitle".tr(),
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
              "screens.settings.language.title".tr(),
              style: defaultTextStyle,
            ),
            subtitle: Text(
              "screens.settings.language.subtitle".tr(),
              style: TextStyle(
                color: themeColors.secondaryTextColor,
              ),
            ),
            leading: Icon(Icons.language),
            onTap: () => showDialog(
              context: context, 
              builder: (context) => SelectableDialog(
                titleKey: "screens.settings.language.select_language", 
                items: [
                  _buildLanguageTile(context, 'English', themeColors),
                  _buildLanguageTile(context, 'فارسی', themeColors),
                ]
              )
            ),
          ),

          const Divider(
            color: Colors.grey,
            thickness: 0.7,
          ),
          SwitchListTile(
            title: Text(
              "screens.settings.enable_hot_connect.title".tr(),
              style: defaultTextStyle,
            ),
            subtitle: Text(
               "screens.settings.enable_hot_connect.subtitle".tr(),
              style: TextStyle(
                color: themeColors.secondaryTextColor,
              ),
            ),
            secondary: Icon(FontAwesomeIcons.fire),
            inactiveThumbColor: themeColors.disabledColor,
            activeColor: themeColors.enabledColor,
            activeTrackColor: themeColors.enabledColor.withAlpha(25),
            inactiveTrackColor: Colors.grey.shade700.withAlpha(70),
            value: _hotConnectEnabled,
            onChanged: (value) {
              setState(() {
                _hotConnectEnabled = value;
              });
              _saveSettings();
            },
          ),
          SwitchListTile(
            title: Text(
              "screens.settings.enable_tips.title".tr(),
              style: defaultTextStyle,
            ),
            subtitle: Text(
               "screens.settings.enable_tips.subtitle".tr(),
              style: TextStyle(
                color: themeColors.secondaryTextColor,
              ),
            ),
            secondary: Icon(Icons.lightbulb),
            inactiveThumbColor: themeColors.disabledColor,
            activeColor: themeColors.enabledColor,
            activeTrackColor: themeColors.enabledColor.withAlpha(25),
            inactiveTrackColor: Colors.grey.shade700.withAlpha(70),
            value: _tipsEnabled,
            onChanged: (value) {
              setState(() {
                _tipsEnabled = value;
              });
              _saveSettings();
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  SwitchListTile(
                    title: Text(
                       "screens.settings.enable_auto_update.title".tr(),
                      style: defaultTextStyle,
                    ),
                    secondary: Icon(FontAwesomeIcons.rotateRight),
                    subtitle: Text(
                      "screens.settings.enable_auto_update.subtitle".tr(),
                      style: TextStyle(
                        color: themeColors.secondaryTextColor,
                      ),
                    ),
                    inactiveThumbColor: themeColors.disabledColor,
                    activeColor: themeColors.enabledColor,
                    activeTrackColor: themeColors.enabledColor.withAlpha(25),
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
                            "screens.settings.update_interval.description".tr(),
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
                            fontFamily: "Vazirmatn"
                          )
                        ), 
                          child: Slider(
                            value: _updateInterval,
                            min: 1,
                            max: 24,
                            divisions: 23,
                            activeColor: themeColors.enabledColor,
                            label: "screens.settings.update_interval.label".tr(
                              args: [localizeNumber(_updateInterval.toInt())]
                            ),
                            onChanged: (value) {
                              setState(() {
                                _updateInterval = value;
                                _saveSettings();
                              });
                            },
                            inactiveColor: themeColors.disabledColor.withAlpha(25),
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

  Future<void> _saveSelectedLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);
  }

  void _changeLocale(BuildContext context, String language) {
    Locale? newLocale;
    switch (language) {
      case 'English':
        newLocale = Locale('en', 'US');
        break;
      case 'فارسی':
        newLocale = Locale('fa', 'IR');
        break;
      default:
        return;
    }

    context.setLocale(newLocale);
  }


  Widget _buildLanguageTile(
    BuildContext context, String language, ThemeColors themeColors) {
    return ListTile(
      title: Text(
        language,
        style: TextStyle(color: themeColors.textColor),
      ),
      leading: Radio<String>(
        activeColor: themeColors.enabledColor,
        value: language,
        groupValue: _selectedLanguage,
        onChanged: (String? value) {
          setState(() {
            logger.debug(value);
            _selectedLanguage = value!;
            _saveSelectedLanguage(value);
            _changeLocale(context, value);
          });
        },
      ),
      onTap: () {
        setState(() {
            logger.debug(language);
          _selectedLanguage = language;
          _saveSelectedLanguage(language);
          _changeLocale(context, language);
        });
      },
    );
  }

  Widget _buildThemeTile(BuildContext context, String themeValue, ThemeColors themeColors) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    return ListTile(
      title: Text(
        "screens.settings.app_theme.themes.$themeValue".tr(),
        style: Theme.of(context).textTheme.labelLarge,
      ),
      leading: Radio<String>(
        activeColor: themeColors.enabledColor,
        value: themeValue,
        groupValue: _appTheme,
        onChanged: (String? value) {
          if (value != null) {
            setState(() {
              _saveSettings();
              _appTheme = value;
              provider.updateTheme(AppTheme.fromString(value));
            });
          }
        },
      ),
      onTap: () {
        setState(() {
          _saveSettings();
          _appTheme = themeValue;
          provider.updateTheme(AppTheme.fromString(themeValue)); 
        });
      },
    );
  }
}
