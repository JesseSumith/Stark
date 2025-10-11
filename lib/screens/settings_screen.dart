import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProv = context.watch<LocaleProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localeProv.translate(en: 'Settings', te: 'సెట్టింగ్స్'),
        ),
        backgroundColor: Colors.green.shade600,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Language Selection Card ---
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localeProv.translate(en: 'Language', te: 'భాష'),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ChoiceChip(
                            label: const Text('English'),
                            selected: localeProv.locale == AppLocale.en,
                            onSelected: (_) =>
                                localeProv.switchTo(AppLocale.en),
                            selectedColor: Colors.green.shade600,
                            labelStyle: TextStyle(
                                color: localeProv.locale == AppLocale.en
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          const SizedBox(width: 12),
                          ChoiceChip(
                            label: const Text('తెలుగు'),
                            selected: localeProv.locale == AppLocale.te,
                            onSelected: (_) =>
                                localeProv.switchTo(AppLocale.te),
                            selectedColor: Colors.green.shade600,
                            labelStyle: TextStyle(
                                color: localeProv.locale == AppLocale.te
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- App Info Card ---
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localeProv.translate(
                              en: 'App Info', te: 'యాప్ సమాచారం'),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Market Advisor • MVP',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Version 1.0.0',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ]),
                ),
              ),

              const SizedBox(height: 24),

              // --- Optional: Theme or other settings placeholder ---
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    localeProv.translate(
                        en: 'More settings coming soon...',
                        te: 'మరిన్ని సెట్టింగ్స్ త్వరలో...'),
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
