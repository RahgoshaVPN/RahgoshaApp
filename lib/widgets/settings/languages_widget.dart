import 'package:flutter/material.dart';
import 'package:rahgosha/common/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageWidget extends StatefulWidget {
  final String selectedLanguage;

  const LanguageWidget({super.key, required this.selectedLanguage});

  @override
  // ignore: library_private_types_in_public_api
  _LanguageWidgetState createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage =
        widget.selectedLanguage;
  }

  
  void _saveSelectedLanguage(String language) async {
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
      // case '中文':
      //   newLocale = Locale('zh', 'CN');
      //   break;
      // case 'русский':
      //   newLocale = Locale('ru', 'RU');
      //   break;
      default:
        return; 
    }

    setState(() {
      context.setLocale(newLocale!);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: themeColors.secondaryTextColor,
        ),
        title: Text(
          "screens.settings.language.select_language".tr(),
          style: TextStyle(
            color: themeColors.secondaryTextColor,
          ),
        ),
        backgroundColor: themeColors.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildLanguageTile(context, 'English'),
                  _buildLanguageTile(context, 'فارسی'),
                  // _buildLanguageTile(context, '中文'),
                  // _buildLanguageTile(context, 'русский'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTile(BuildContext context, String language) {
    return ListTile(
      title: Text(
        language, 
        textAlign: TextAlign.left,
        style: TextStyle(
          color: themeColors.textColor,
        ),
      ),
      leading: Radio<String>(
        activeColor: themeColors.primaryColor,
        value: language,
        groupValue: _selectedLanguage,
        onChanged: (String? value) {
          setState(() {
            _selectedLanguage = value!;
            _saveSelectedLanguage(value);
            _changeLocale(context, value); 
          });
        },
      ),
      onTap: () {
        setState(() {
          _selectedLanguage = language;
          _saveSelectedLanguage(language);
          _changeLocale(context, language);
        });
      },
    );
  }
}