import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {

  // normal
  runApp(const ThemeShowcaseApp());
  // getx
  // runApp(const ThemeShowcaseGetxApp());
}

// GetX Controller
class ThemeController extends GetxController {
  var currentTheme = AppThemeType.light.obs;

  void setTheme(AppThemeType themeType) {
    currentTheme.value = themeType;
    Get.changeTheme(AppTheme.getTheme(themeType));
  }
}

class ThemeShowcaseGetxApp extends StatelessWidget {
  const ThemeShowcaseGetxApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() => GetMaterialApp(
      title: 'Theme Showcase getx',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(themeController.currentTheme.value),
      home: const ThemeShowcaseScreen(),
    ));
  }
}

// normal ----------------
// normal
class ThemeShowcaseApp extends StatelessWidget {
  const ThemeShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppThemeType>(
      valueListenable: AppTheme.currentTheme,
      builder: (context, themeType, child) {
        return MaterialApp(
          title: 'Theme Showcase',
          debugShowCheckedModeBanner: false,
          // Dynamically get the theme based on the current selection
          theme: AppTheme.getTheme(themeType),
          home: const ThemeShowcaseScreen(),
        );
      },
    );
  }
}
// normal end ----------------

// =================================
// CENTRALIZED THEME CONFIGURATION
// =================================
enum AppThemeType { light, dark, cosmic }

class AppTheme {
  static const String _fontFamily = 'Roboto';

  // Light Theme
  static ThemeData get lightTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: _fontFamily,
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: _fontFamily,
    );
  }

  // Cosmic Theme (Example third theme)
  static ThemeData get cosmicTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.deepOrange,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: _fontFamily,
    );
  }

  // Helper to get ThemeData from Enum
  static ThemeData getTheme(AppThemeType type) {
    switch (type) {
      case AppThemeType.light:
        return lightTheme;
      case AppThemeType.dark:
        return darkTheme;
      case AppThemeType.cosmic:
        return cosmicTheme;
    }
  }

  // normal

  // controller area
  static final ValueNotifier<AppThemeType> currentTheme = ValueNotifier(AppThemeType.light);

  // Method to set a specific theme
  static void setTheme(AppThemeType type) {
    currentTheme.value = type;
  }

  // Method to cycle to the next theme (optional)
  static void cycleTheme() {
    final nextIndex = (currentTheme.value.index + 1) % AppThemeType.values.length;
    currentTheme.value = AppThemeType.values[nextIndex];
  }

// normal ends


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

}

// =================================
// THEME SHOWCASE SCREEN
// =================================
class ThemeShowcaseScreen extends StatelessWidget {
  const ThemeShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Theme Showcase', style: theme.textTheme.titleLarge),
            // getx area
            // Obx(() {
            //   final controller = Get.find<ThemeController>();
            //   String themeName = controller.currentTheme.value.name;
            //   themeName = themeName[0].toUpperCase() + themeName.substring(1);
            //   return Text(
            //     'Material 3 Design System - $themeName',
            //     style: theme.textTheme.bodySmall?.copyWith(
            //       color: colorScheme.onSurface.withValues(alpha: 0.6),
            //     ),
            //   );
            // }),
            // getx area ends

          ],
        ),
        actions: [
          PopupMenuButton<AppThemeType>(
            icon: const Icon(Icons.color_lens),
            onSelected: (AppThemeType result) {
              // normal

              AppTheme.setTheme(result);
              // normal ends
              // Get.find<ThemeController>().setTheme(result);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<AppThemeType>>[
              const PopupMenuItem(
                value: AppThemeType.light,
                child: Text('Light Mode'),
              ),
              const PopupMenuItem(
                value: AppThemeType.dark,
                child: Text('Dark Mode'),
              ),
              const PopupMenuItem(
                value: AppThemeType.cosmic,
                child: Text('Cosmic Mode'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ColorSchemeSection(),
            const SizedBox(height: 32),
            _ButtonsSection(),
            const SizedBox(height: 32),
            _InputsSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// =================================
// COLOR SCHEME SECTION
// =================================
class _ColorSchemeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color Scheme', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _ColorCard('primary', colorScheme.primary, colorScheme.onPrimary),
            _ColorCard('secondary', colorScheme.secondary, colorScheme.onSecondary),
            _ColorCard('tertiary', colorScheme.tertiary, colorScheme.onTertiary),
            _ColorCard('surface', colorScheme.surface, colorScheme.onSurface),
            _ColorCard('background', colorScheme.surface, colorScheme.onSurface),
            _ColorCard('error', colorScheme.error, colorScheme.onError),
          ],
        ),
      ],
    );
  }
}

class _ColorCard extends StatelessWidget {
  final String name;
  final Color color;
  final Color onColor;

  const _ColorCard(this.name, this.color, this.onColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          name,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: onColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// =================================
// BUTTONS SECTION
// =================================
class _ButtonsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Buttons', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
                FilledButton(onPressed: () {}, child: const Text('Filled')),
                OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
                TextButton(onPressed: () {}, child: const Text('Text')),
                ElevatedButton(onPressed: null, child: const Text('Disabled')),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('With Icon'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// =================================
// INPUTS SECTION
// =================================
class _InputsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Text Inputs', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'TextField',
                    hintText: 'Enter some text',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'TextFormField with Error',
                    hintText: 'This field has an error',
                    prefixIcon: Icon(Icons.email),
                    errorText: 'Invalid email address',
                  ),
                ),
                const SizedBox(height: 16),
                const TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Disabled TextField',
                    hintText: 'This field is disabled',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}