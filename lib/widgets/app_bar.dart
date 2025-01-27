import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rahgosha/screens/settings_page.dart';
import 'package:rahgosha/common/theme.dart';
import 'package:rahgosha/utils/providers.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = context.watch<ThemeProvider>().getColors(context);
    return AppBar(
      backgroundColor: themeColors.secondaryBackgroundColor,
      surfaceTintColor: themeColors.backgroundColor,
      scrolledUnderElevation: 4.0,
      elevation: 0,
      title: Text(
        "general.app_name".tr(),
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontFamily: "Vazirmatn"
        ),
      ),
      titleTextStyle: TextStyle(
        color: themeColors.secondaryTextColor,
      ),
      leading: IconButton(
        icon: Icon(Icons.menu, color: themeColors.secondaryTextColor),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        highlightColor: themeColors.secondaryTextColor.withAlpha(50),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.settings, 
            color: themeColors.secondaryTextColor
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
          highlightColor: themeColors.secondaryTextColor.withAlpha(50),
        ),
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.github, 
            color: themeColors.secondaryTextColor,
            size: 20,
          ),
          onPressed: () async {
            await launchUrl(
              Uri.parse('https://github.com/RahgoshaVPN/RahgoshaApp'),
              mode: LaunchMode.externalApplication
            );
          },
        highlightColor: themeColors.secondaryTextColor.withAlpha(50),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
