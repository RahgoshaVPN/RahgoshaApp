import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:rahgosha/common/logger.dart';
import 'package:rahgosha/screens/home_screen.dart';
import 'package:rahgosha/screens/servers_screen.dart';
import 'package:rahgosha/utils/appcache.dart';
import 'package:rahgosha/utils/tools.dart';
import 'package:rahgosha/widgets/app_bar.dart';
import 'package:rahgosha/widgets/drawer.dart';
import 'package:rahgosha/common/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rahgosha/utils/notifiers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Gather initialization tasks for parallel execution
  await Future.wait([
    EasyLocalization.ensureInitialized(),
    _initializeApp(),
    _getAppVersion(),
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: themeColors.secondaryBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => V2RayStatusNotifier()),
        ChangeNotifierProvider(create: (_) => V2RayURLNotifier()),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('fa', 'IR'),
        ],
        path: 'assets/translations',
        saveLocale: true,
        fallbackLocale: const Locale('en', 'US'),
        startLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
    ),
  );
}

// Initialize app-specific settings
Future<void> _initializeApp() async {
  try {
    setupLogging(Level.ALL);

    // Fetch shared preferences asynchronously
    final prefs = await SharedPreferences.getInstance();

    // Read user choice from preferences
    final userChoice = prefs.getString("userChoice");
    logger.debug("User choice on main: $userChoice");

    // Perform auto-update tasks if enabled
    
    if (prefs.getBool("autoUpdateEnabled") ?? true) {
      logger.debug("Auto update is enabled!");
      await Future.wait([
        reloadStorage(userChoice: userChoice ?? "Automatic"),
        reloadCache(),
      ]);
    } else {
      await reloadCache();
    }
  } catch (err) {
    logger.error("Failed to initialize app: $err");
  }
}

// Fetch the app version and cache it
Future<void> _getAppVersion() async {
  try {
    final packageInfo = await PackageInfo.fromPlatform();
    cache.set("version", packageInfo.version);
  } catch (err) {
    logger.error("Failed to fetch app version: $err");
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
        brightness: Brightness.dark
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
              label: "screens.root.home".tr(),
            ),
            NavigationDestination(
              icon: FaIcon(
                FontAwesomeIcons.server,
                color: themeColors.secondaryTextColor,
              ),
              label: "screens.root.servers".tr(),
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