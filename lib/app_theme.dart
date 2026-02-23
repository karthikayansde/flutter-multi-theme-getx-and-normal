import 'package:flutter/material.dart';
import 'package:flutter_multi_theme_getx_and_normal/main.dart';
import 'package:get/get.dart';
import 'app_color_schemes.dart';
class AppTheme {
  final bool isNative;
  final List<AppThemeModel> colorSchemes;
  final ILocalStorage storage;
  // --- singleton start ---
  static AppTheme? _instance;
  AppTheme._internal({
    required this.isNative,
    required this.colorSchemes,
    required this.storage,
  });
  factory AppTheme({
    required bool isNative,
    required List<AppThemeModel> colorSchemes,
    required ILocalStorage storage,
  }){
    _instance ??= AppTheme._internal(
      isNative: isNative,
      colorSchemes: colorSchemes,
      storage: storage,
    );
    return _instance!;
  }
  static AppTheme get instance {
    if (_instance == null) {
      throw Exception("AppTheme must be initialized by calling the factory constructor first.");
    }
    return _instance!;
  }
  // --- singleton over ---

  // --- storage area start ---
  final _storageKey = 'app_theme';
  Future<void> setTheme(String themeKey) async {
    await storage.write(_storageKey, themeKey);
  }
  String getTheme() {
    return storage.read(_storageKey) ?? AppColorSchemes.defaultThemeKey;
  }
  // --- storage area over ---

  // --- dropdown UI builder start ---
  Widget dropdownBuilder(
      Widget Function(
          String selectedKey,
          Map<String, AppThemeModel> themeMap,
          void Function(String key) changeTheme,
          ) builder,
      ) {
    return _AppThemeDropdownBuilder(appTheme: this, builder: builder);
  }
  // --- dropdown UI builder over ---

  // --- app theme builder start ---
  Widget themeWrapper(
      Widget Function(
          ThemeData theme,
          ThemeData darkTheme,
          ThemeMode themeMode
          ) builder,
      ) {
    final String selectedTheme = getTheme();
    return isNative? _AppThemeBuilder(selectedTheme: selectedTheme, colorSchemes: colorSchemes, builder: builder) : _GetAppThemeBuilder(selectedTheme: selectedTheme, colorSchemes: colorSchemes, builder: builder);
  }
  // --- app theme builder over ---

  // --- update theme start ---
  Future<void> updateTheme(String themeKey) async {
    await setTheme(themeKey);
    if(isNative){
      NormalThemeController().setTheme(themeKey);
    }else{
      Get.find<GetThemeController>().setTheme(themeKey);
    }
  }
// --- update theme over ---

// AppThemeModel getTheme(String type) {
//   return options.firstWhere(
//         (theme) => theme.key == type,
//     orElse: () => options[0],
//   );
// }
}

// --- drop down class start ---
class _AppThemeDropdownBuilder extends StatefulWidget {
  final AppTheme appTheme;
  final Widget Function(
      String selectedKey,
      Map<String, AppThemeModel> themeMap,
      void Function(String key) changeTheme,
      ) builder;

  const _AppThemeDropdownBuilder({
    required this.appTheme,
    required this.builder,
  });

  @override
  State<_AppThemeDropdownBuilder> createState() => _AppThemeDropdownBuilderState();
}

class _AppThemeDropdownBuilderState extends State<_AppThemeDropdownBuilder> {
  late String _selectedKey;

  @override
  void initState() {
    super.initState();
    _selectedKey = widget.appTheme.getTheme();
  }

  void _changeTheme(String key) {
    widget.appTheme.setTheme(key);
    setState(() => _selectedKey = key);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      _selectedKey,
      {for (var s in widget.appTheme.colorSchemes) s.key: s},
      _changeTheme,
    );
  }
}
// --- drop down class over ---

// normal or flutter theme
class NormalThemeController {
  static final NormalThemeController _singleton = NormalThemeController._internal();
  factory NormalThemeController() {
    return _singleton;
  }
  NormalThemeController._internal();
  // controller area
  final ValueNotifier<String> currentTheme = ValueNotifier(AppColorSchemes.defaultThemeKey);

  // Method to set a specific theme
  void setTheme(String type) {
    currentTheme.value = type;
  }
}

class _AppThemeBuilder extends StatelessWidget {
  final List<AppThemeModel> colorSchemes;
  final String selectedTheme;
  final Widget Function(
      ThemeData theme,
      ThemeData darkTheme,
      ThemeMode themeMode
      ) builder;

  _AppThemeBuilder({
    required this.selectedTheme,
    required this.colorSchemes,
    required this.builder,
  });
  final NormalThemeController controller = NormalThemeController();
  @override
  Widget build(BuildContext context) {
    // Sync controller with the persisted theme from storage on first build
    if (controller.currentTheme.value != selectedTheme) {
      controller.setTheme(selectedTheme);
    }
    return ValueListenableBuilder<String>(
      valueListenable: controller.currentTheme,
      builder: (context, themeKey, child) {
        final resolvedTheme = colorSchemes.firstWhere(
              (e) => e.key == themeKey,
          orElse: () => colorSchemes.firstWhere(
                (element) => element.key == AppColorSchemes.defaultThemeKey,
          ),
        );
        final lightTheme = colorSchemes[1].data;
        final darkTheme = colorSchemes[2].data;

        ThemeData effectiveTheme = lightTheme;
        ThemeData effectiveDarkTheme = darkTheme;
        ThemeMode themeMode = resolvedTheme.mode;

        if (resolvedTheme.mode == ThemeMode.dark) {
          effectiveDarkTheme = resolvedTheme.data;
        } else if (resolvedTheme.mode == ThemeMode.light) {
          effectiveTheme = resolvedTheme.data;
        }

        return builder(effectiveTheme, effectiveDarkTheme, themeMode);
      },
    );
  }
}

// getX theme
class GetThemeController extends GetxController {
  final List<AppThemeModel> colorSchemes;
  GetThemeController(this.colorSchemes);
  void setTheme(String themeKey) {
    for(var theme in colorSchemes){
      if(theme.key == themeKey){
        Get.changeThemeMode(theme.mode);
        Get.changeTheme(theme.data);
      }
    }
  }
}

class _GetAppThemeBuilder extends StatefulWidget {
  final String selectedTheme;
  final List<AppThemeModel> colorSchemes;
  final Widget Function(
      ThemeData theme,
      ThemeData darkTheme,
      ThemeMode themeMode,
      ) builder;

  const _GetAppThemeBuilder({
    required this.selectedTheme,
    required this.colorSchemes,
    required this.builder,
  });

  @override
  State<_GetAppThemeBuilder> createState() => _GetAppThemeBuilderState();
}

class _GetAppThemeBuilderState extends State<_GetAppThemeBuilder> {
  late final GetThemeController _controller;
  late final ThemeData _theme;
  late final ThemeData _darkTheme;
  final ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _theme = widget.colorSchemes[1].data;
    _darkTheme = widget.colorSchemes[2].data;
    _controller = Get.put(GetThemeController(widget.colorSchemes));
    _controller.setTheme(widget.selectedTheme);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_theme, _darkTheme, _themeMode);
  }
}

/// storage need to init first then theme
// // First time (Initialization)
// final theme = AppTheme(
//     isNative: true,
//     colorSchemes: mySchemes,
//     storage: myStorage
// );
//
// // Anywhere else in your app
// final sameTheme = AppTheme.instance;

// AppTheme.instance.dropdownBuilder(
//       (selectedKey, themeMap, changeTheme) {
//     return DropdownButton<String>(
//       value: selectedKey,
//       onChanged: (key) {
//         changeTheme(key!);
//         AppTheme.instance.updateTheme(key);
//       },
//       items: themeMap.entries
//           .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value.name)))
//           .toList(),
//     );
//   },
// ),