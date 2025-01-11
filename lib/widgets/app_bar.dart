import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rahgosha/screens/settings_page.dart';
import 'package:rahgosha/widgets/theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: themeColors.secondaryBackgroundColor,
      surfaceTintColor: themeColors.primaryColor,
      scrolledUnderElevation: 4.0,
      elevation: 0,
      title: Text(
        context.tr("app_name"),
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
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
          onPressed: () {
            // TODO: Link to GitHub
          },
        highlightColor: themeColors.secondaryTextColor.withAlpha(50),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
