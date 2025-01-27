import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rahgosha/common/theme.dart';
import 'package:rahgosha/utils/providers.dart';
import 'dart:ui' as ui;

import 'package:rahgosha/utils/tools.dart';

class SelectableDialog extends StatefulWidget {
  final String titleKey;
  final List<Widget> items;

  const SelectableDialog({super.key, required this.titleKey, required this.items});

  @override
  // ignore: library_private_types_in_public_api
  _SelectableDialogState createState() => _SelectableDialogState();
}

class _SelectableDialogState extends State<SelectableDialog> {
  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = Provider.of<ThemeProvider>(context).getColors(context);

    return AlertDialog(
      backgroundColor: themeColors.backgroundColor,
      title: Text(
        widget.titleKey.tr(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...widget.items,
          const SizedBox(height: 16),
          Align(
            alignment: Directionality.of(context) == ui.TextDirection.ltr
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                safePop(context);
              },
              child: Text(
                "general.close".tr(),
                style: TextStyle(color: themeColors.enabledColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}