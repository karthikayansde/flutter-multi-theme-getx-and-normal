import 'package:flutter/material.dart';
import 'package:flutter_multi_theme_getx_and_normal/app_theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app_color_schemes.dart';

Future<void> main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  AppTheme(isNative: false, colorSchemes: AppColorSchemes(TextTheme()).options, storage: _localStorage!);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return AppTheme.instance.themeWrapper(
            (theme, darkTheme, themeMode) {
          return GetMaterialApp(
            theme: theme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            title: "Multi-Theme",
            home: HomeScreen(),
          );
        }
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data"),),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTheme.instance.dropdownBuilder(
                  (selectedKey, themeMap, changeTheme) {
                return DropdownButton<String>(
                  value: selectedKey,
                  onChanged: (key) {
                    changeTheme(key!);
                    AppTheme.instance.updateTheme(key);
                  },
                  items: themeMap.entries
                      .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value.name)))
                      .toList(),
                );
              },
            ),
            _ColorSchemeSection(),
            SizedBox(height: 32),
            _ButtonsSection(),
            SizedBox(height: 32),
            _InputsSection(),
            SizedBox(height: 32),
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
  const _ColorSchemeSection();
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
  const _ButtonsSection();
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
  const _InputsSection();
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

abstract class ILocalStorage {
  Future<void> init();
  Future<void> write<T>(String key, T value);
  T? read<T>(String key);
  Future<void> delete(String key);
  Future<void> deleteAll();
  Future<bool> containsKey(String key);
}

class LocalStorageService implements ILocalStorage {
  late final GetStorage _box;
  @override
  Future<void> init() async {
    await GetStorage.init();
    _box = GetStorage();
  }

  @override
  Future<void> write<T>(String key, T value) async => await _box.write(key, value);

  @override
  T? read<T>(String key) => _box.read<T>(key);

  @override
  Future<void> delete(String key) async => await _box.remove(key);

  @override
  Future<void> deleteAll() async => await _box.erase();

  @override
  Future<bool> containsKey(String key) async => _box.hasData(key);

}

ILocalStorage? _localStorage;
Future<void> initLocalStorage() async {
  if (_localStorage != null) return;
  _localStorage = LocalStorageService();
  await _localStorage!.init();
}