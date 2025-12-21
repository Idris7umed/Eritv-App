import 'package:flutter/material.dart';
import '../services/localization_service.dart';
import '../services/theme_service.dart';
import '../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Function(ThemeMode) onThemeModeChange;

  const SettingsScreen({
    super.key,
    required this.onLocaleChange,
    required this.onThemeModeChange,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final LocalizationService _localizationService = LocalizationService();
  final ThemeService _themeService = ThemeService();
  Locale? _currentLocale;
  ThemeMode? _currentThemeMode;

  @override
  void initState() {
    super.initState();
    _loadCurrentLocale();
    _loadCurrentThemeMode();
  }

  Future<void> _loadCurrentLocale() async {
    final locale = await _localizationService.getLocale();
    setState(() {
      _currentLocale = locale;
    });
  }

  Future<void> _loadCurrentThemeMode() async {
    final themeMode = await _themeService.getThemeMode();
    setState(() {
      _currentThemeMode = themeMode;
    });
  }

  Future<void> _changeLanguage(Locale locale) async {
    await _localizationService.setLocale(locale);
    setState(() {
      _currentLocale = locale;
    });
    widget.onLocaleChange(locale);
  }

  Future<void> _changeThemeMode(ThemeMode mode) async {
    await _themeService.setThemeMode(mode);
    setState(() {
      _currentThemeMode = mode;
    });
    widget.onThemeModeChange(mode);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.settings ?? 'Settings'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          ListTile(
            leading: Icon(Icons.language, color: isDark ? Colors.white : Colors.black87),
            title: Text(
              l10n?.language ?? 'Language',
              style: TextStyle(color: isDark ? Colors.white : Colors.black87),
            ),
            subtitle: _currentLocale != null
                ? Text(
                    LocalizationService.getLanguageNameForLocale(_currentLocale!),
                    style: TextStyle(color: isDark ? Colors.white60 : Colors.black54),
                  )
                : null,
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: isDark ? Colors.white60 : Colors.black54),
            onTap: () => _showLanguageDialog(),
          ),
          Divider(color: isDark ? Colors.white24 : Colors.black12),
          ListTile(
            leading: Icon(Icons.palette, color: isDark ? Colors.white : Colors.black87),
            title: Text(
              l10n?.theme ?? 'Theme',
              style: TextStyle(color: isDark ? Colors.white : Colors.black87),
            ),
            subtitle: _currentThemeMode != null
                ? Text(
                    _themeService.getThemeModeName(
                      _currentThemeMode!,
                      lightLabel: l10n?.light,
                      darkLabel: l10n?.dark,
                      systemLabel: l10n?.system,
                    ),
                    style: TextStyle(color: isDark ? Colors.white60 : Colors.black54),
                  )
                : null,
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: isDark ? Colors.white60 : Colors.black54),
            onTap: () => _showThemeDialog(),
          ),
          Divider(color: isDark ? Colors.white24 : Colors.black12),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Theme.of(context).dialogBackgroundColor,
          title: Text(
            l10n?.selectLanguage ?? 'Select Language',
            style: TextStyle(color: isDark ? Colors.white : Colors.black87),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: LocalizationService.supportedLocales.map((locale) {
              final isSelected = _currentLocale?.languageCode == locale.languageCode;
              return ListTile(
                title: Text(
                  LocalizationService.getLanguageNameForLocale(locale),
                  style: TextStyle(
                    color: isSelected ? Theme.of(context).primaryColor : (isDark ? Colors.white : Colors.black87),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: isSelected
                    ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                    : null,
                onTap: () {
                  _changeLanguage(locale);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showThemeDialog() {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final themeModes = [
      ThemeMode.light,
      ThemeMode.dark,
      ThemeMode.system,
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Theme.of(context).dialogBackgroundColor,
          title: Text(
            l10n?.selectTheme ?? 'Select Theme',
            style: TextStyle(color: isDark ? Colors.white : Colors.black87),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: themeModes.map((mode) {
              final isSelected = _currentThemeMode == mode;
              final themeName = _themeService.getThemeModeName(
                mode,
                lightLabel: l10n?.light,
                darkLabel: l10n?.dark,
                systemLabel: l10n?.system,
              );
              
              return ListTile(
                title: Text(
                  themeName,
                  style: TextStyle(
                    color: isSelected ? Theme.of(context).primaryColor : (isDark ? Colors.white : Colors.black87),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: isSelected
                    ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                    : null,
                onTap: () {
                  _changeThemeMode(mode);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
