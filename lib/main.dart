import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';

import 'providers/product_provider.dart';
import 'providers/locale_provider.dart';
import 'screens/splash_screen.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MarketAdvisorApp());
}

class MarketAdvisorApp extends StatelessWidget {
  const MarketAdvisorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ],
        child: Consumer<LocaleProvider>(
          builder: (context, localeProvider, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Market Advisor',
              theme: AppTheme.lightTheme,
              home: const SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}
