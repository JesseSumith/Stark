import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProv = context.watch<LocaleProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text('Language'),
          Row(children: [
            Radio<LocaleProvider>(
              value: localeProv,
              groupValue: localeProv,
              onChanged: (_) {},
            ),
            ElevatedButton(
              onPressed: () => localeProv.switchTo(AppLocale.en),
              child: const Text('English'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => localeProv.switchTo(AppLocale.te),
              child: const Text('తెలుగు'),
            ),
          ]),
          const SizedBox(height: 24),
          const Text('App Info'),
          const SizedBox(height: 8),
          const Text('Market Advisor • MVP'),
        ]),
      ),
    );
  }
}
