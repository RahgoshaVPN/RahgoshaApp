import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:rahgosha/logger.dart';
import 'package:rahgosha/screens/home_screen.dart';
import 'package:rahgosha/screens/servers_screen.dart';
import 'package:rahgosha/utils/appcache.dart';
import 'package:rahgosha/utils/tools.dart';
import 'package:rahgosha/widgets/app_bar.dart';
import 'package:rahgosha/widgets/drawer.dart';
import 'package:rahgosha/widgets/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await _initializeApp();
  final packageInfo = await PackageInfo.fromPlatform();

  cache.set("version", packageInfo.version);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => V2RayStatusNotifier()),
      ],
      child: EasyLocalization(
        supportedLocales: [
          Locale('en', 'US'),
          Locale('fa', 'IR'),
        ],
        path: 'assets/translations',
        saveLocale: true,
        fallbackLocale: Locale('en', 'US'),
        startLocale: Locale('en', 'US'),
        child: MyApp(),
      ),
    ),
  );
}

Future<void> _initializeApp() async {
  try {
    setupLogging(Level.ALL);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userChoice = prefs.getString("userChoice");
    logger.debug("keys: \${prefs.getKeys()}");
    logger.debug("values: \${prefs.getKeys().map((key) => prefs.get(key))}");
    logger.debug("User choice on main: $userChoice");
    await reloadStorage(userChoice: userChoice ?? "Automatic");
    await reloadCache();
  } catch (err) {
    logger.error("Failed to initialize app: $err");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        textTheme: defaultTextTheme,
        scaffoldBackgroundColor: themeColors.backgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    late final List<Widget> pages = [
      HomeScreen(),
      ServersScreen(),
    ];

    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return TextStyle(
                  color: themeColors.secondaryTextColor,
                );
              }
              return TextStyle(
                color: themeColors.secondaryTextColor,
              );
            },
          ),
        ),
        child: NavigationBar(
          backgroundColor: themeColors.secondaryBackgroundColor,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home,
                color: themeColors.secondaryTextColor,
              ),
              label: "Home",
            ),
            NavigationDestination(
              icon: FaIcon(
                FontAwesomeIcons.server,
                color: themeColors.secondaryTextColor,
              ),
              label: "Servers",
            ),
          ],
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          shadowColor: themeColors.secondaryTextColor.withAlpha(125),
          elevation: 0,
          overlayColor: WidgetStateColor.transparent,
          indicatorColor: themeColors.secondaryTextColor.withAlpha(125),
          surfaceTintColor: themeColors.primaryColor,
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      drawer: DrawerWidget(),
    );
  }

}
