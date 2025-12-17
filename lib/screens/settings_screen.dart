import 'package:flutter/material.dart';
import '../services/localization_service.dart';
import '../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const SettingsScreen({super.key, required this.onLocaleChange});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final LocalizationService _localizationService = LocalizationService();
  Locale? _currentLocale;

  @override
  void initState() {
    super.initState();
    _loadCurrentLocale();
  }

  Future<void> _loadCurrentLocale() async {
    final locale = await _localizationService.getLocale();
    setState(() {
      _currentLocale = locale;
    });
  }

  Future<void> _changeLanguage(Locale locale) async {
    await _localizationService.setLocale(locale);
    setState(() {
      _currentLocale = locale;
    });
    widget.onLocaleChange(locale);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.settings ?? 'Settings'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.language, color: Colors.white),
            title: Text(
              l10n?.language ?? 'Language',
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: _currentLocale != null
                ? Text(
                    LocalizationService.getLanguageNameForLocale(_currentLocale!),
                    style: const TextStyle(color: Colors.white60),
                  )
                : null,
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white60),
            onTap: () => _showLanguageDialog(),
          ),
          const Divider(color: Colors.white24),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    final l10n = AppLocalizations.of(context);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: Text(
            l10n?.selectLanguage ?? 'Select Language',
            style: const TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: LocalizationService.supportedLocales.map((locale) {
              final isSelected = _currentLocale?.languageCode == locale.languageCode;
              return ListTile(
                title: Text(
                  LocalizationService.getLanguageNameForLocale(locale),
                  style: TextStyle(
                    color: isSelected ? Theme.of(context).primaryColor : Colors.white,
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
}
