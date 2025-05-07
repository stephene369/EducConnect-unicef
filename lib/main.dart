import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/app_provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  // Assurez-vous que les widgets Flutter sont initialisés
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialiser SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(prefs),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    
    return MaterialApp(
      title: 'EduConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: appProvider.isDarkMode ? Brightness.dark : Brightness.light,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      themeMode: appProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
