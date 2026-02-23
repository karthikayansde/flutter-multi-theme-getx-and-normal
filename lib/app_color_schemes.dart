import 'package:flutter/material.dart';

class AppThemeModel {
  final String key;
  final String name;
  final ThemeData data;
  final ThemeMode mode;

  AppThemeModel({
    required this.key,
    required this.name,
    required this.data,
    required this.mode,
  });
}

class AppColorSchemes {
  final TextTheme _textTheme;

  AppColorSchemes(this._textTheme);

  ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    textTheme: _textTheme,
  );

  ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.blue,
    textTheme: _textTheme,
  );

  ThemeData get midnightOcean => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF9600), brightness: Brightness.light),
    textTheme: _textTheme,
  );

  static const String defaultThemeKey = "system";
  List<AppThemeModel> get options => [
    AppThemeModel(
      key: "system",
      name: "System",
      mode: ThemeMode.system,
      data: light, // Default to light if system is requested but context not available
    ),
    AppThemeModel(
      key: "light",
      name: "Light",
      mode: ThemeMode.light,
      data: light,
    ),
    AppThemeModel(
      key: "dark",
      name: "dark",
      mode: ThemeMode.dark,
      data: dark,
    ),
    AppThemeModel(
      key: "midnightOcean",
      name: "Midnight Ocean",
      mode: ThemeMode.light,
      data: midnightOcean,
    ),
  ];
}

// static ThemeData get lightTheme {
//   final ColorScheme colorScheme = ColorScheme.fromSeed(
//     seedColor: Colors.deepPurple,
//
//     brightness: Brightness.light,
//
//     // primary: Colors.red,
//     // onPrimary: Colors.red,
//     // primaryContainer: Colors.red,
//     // onPrimaryContainer: Colors.red,
//     //
//     // primaryFixed: Colors.red,
//     // onPrimaryFixed: Colors.red,
//     // primaryFixedDim: Colors.red,
//     // onPrimaryFixedVariant: Colors.red,
//     //
//     // secondary: Colors.red,
//     // onSecondary: Colors.red,
//     // secondaryContainer: Colors.red,
//     // onSecondaryContainer: Colors.red,
//     //
//     // secondaryFixed: Colors.red,
//     // onSecondaryFixed: Colors.red,
//     // secondaryFixedDim: Colors.red,
//     // onSecondaryFixedVariant: Colors.red,
//     //
//     // tertiary: Colors.red,
//     // onTertiary: Colors.red,
//     // tertiaryContainer: Colors.red,
//     // onTertiaryContainer: Colors.red,
//     //
//     // tertiaryFixed: Colors.red,
//     // onTertiaryFixed: Colors.red,
//     // tertiaryFixedDim: Colors.red,
//     // onTertiaryFixedVariant: Colors.red,
//     //
//     // error: Colors.red,
//     // onError: Colors.red,
//     // errorContainer: Colors.red,
//     // onErrorContainer: Colors.red,
//     //
//     // surfaceDim: Colors.red,
//     // surface: Colors.red,
//     // surfaceBright: Colors.red,
//     // surfaceContainerLowest: Colors.red,
//     // surfaceContainerLow: Colors.red,
//     // surfaceContainer: Colors.red,
//     // surfaceContainerHigh: Colors.red,
//     // surfaceContainerHighest: Colors.red,
//     // onSurface: Colors.red,
//     // onSurfaceVariant: Colors.red,
//     // surfaceTint: Colors.red,
//     //
//     // outline: Colors.red,
//     // shadow: Colors.red,
//     // inverseSurface: Colors.red,
//     // onInverseSurface: Colors.red,
//     // inversePrimary: Colors.red,
//   );
//
//   return ThemeData(
//       useMaterial3: true,
//       colorScheme: colorScheme,
//       fontFamily: _fontFamily
//   );
// }
