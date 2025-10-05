import 'package:flutter/foundation.dart';

enum AppLocale { en, te }

class LocaleProvider extends ChangeNotifier {
  AppLocale _locale = AppLocale.te; // primary Telugu
  AppLocale get locale => _locale;

  void switchTo(AppLocale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }

  // Simple helper to get translated text; a real app should use intl or arb.
  String translate({required String en, required String te}) {
    return _locale == AppLocale.en ? en : te;
  }
}
