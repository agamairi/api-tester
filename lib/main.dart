// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/request_builder.dart';
import 'screens/history_page.dart';
import 'screens/settings_page.dart';
import 'state/app_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load saved preferences before running app
  final prefs = await SharedPreferences.getInstance();
  final savedDarkMode = prefs.getBool('darkMode') ?? false;
  final savedColor = prefs.getInt('themeColor') ?? Colors.blue.value;

  runApp(ApiTesterApp(darkMode: savedDarkMode, themeColor: Color(savedColor)));
}

class ApiTesterApp extends StatelessWidget {
  final bool darkMode;
  final Color themeColor;

  const ApiTesterApp({
    super.key,
    required this.darkMode,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(darkMode: darkMode, themeColor: themeColor),
      child: Consumer<AppState>(
        builder: (ctx, state, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: state.themeColor,
              brightness: state.darkMode ? Brightness.dark : Brightness.light,
            ),
            useMaterial3: true,
          ),
          home: const HomeNavigator(),
        ),
      ),
    );
  }
}

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({super.key});

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  int _currentIndex = 0;

  final screens = const [RequestBuilder(), HistoryPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.send), label: 'Request'),
          NavigationDestination(icon: Icon(Icons.history), label: 'History'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
