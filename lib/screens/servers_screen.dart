import 'package:flutter/material.dart';
import 'package:rahgosha/logger.dart';
import 'package:rahgosha/widgets/theme.dart';


class ServersScreen extends StatefulWidget {
  const ServersScreen({super.key});


  @override
  State<StatefulWidget> createState() => ServersScreenState();
}

class ServersScreenState extends State<ServersScreen> with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileCard("Skibidi", 0),
              _buildProfileCard("Sigma", 1),
              ...[
                for (int i = 2; i < 10; i++) _buildProfileCard("Skibidi: $i", i),
              ],
            ]
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildProfileCard(String name, int index) {
    return Card(
      elevation: 0,
      color: themeColors.backgroundColor,
      child: Row(
        children: [
            Container(
              width: 5,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _selectedIndex == index ? 
                themeColors.primaryColor : themeColors.backgroundColor,
              ),
            ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  logger.debug("Index: $index");
                  _selectedIndex = index;
                });
              },

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  name,
                  style: TextStyle(
                    color: themeColors.secondaryTextColor,
                    fontSize: 16
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
