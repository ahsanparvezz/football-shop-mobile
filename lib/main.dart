import 'package:flutter/material.dart';
import 'package:football_shop/screens/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:football_shop/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'TokoSofita',
        theme: ThemeData(
          brightness: Brightness.dark, // 🌑 Base dark theme
          scaffoldBackgroundColor: const Color(0xFF121212), // Netflix dark background
          colorScheme: ColorScheme.dark(
            primary: Colors.redAccent, // Netflix red
            secondary: Colors.redAccent.shade400,
            surface: const Color(0xFF1C1C1C),
            onPrimary: Colors.white,
            onSecondary: Colors.white,
          ),
          cardColor: const Color(0xFF1F1F1F),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            elevation: 4,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
            bodySmall: TextStyle(color: Colors.grey),
            titleLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.grey[900],
            contentTextStyle: const TextStyle(color: Colors.white),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFF1E1E1E),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            ),
            labelStyle: const TextStyle(color: Colors.white),
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
      ),
    );
  }
}
