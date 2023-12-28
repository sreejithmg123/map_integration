import 'package:flutter/cupertino.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en', ''); // Default locale

  Locale get locale => _locale;

  Future<void> setLocale(Locale newLocale) async {
    Future.delayed(
      const Duration(seconds: 1),
      () => _locale = newLocale,
    );
    notifyListeners();
  }
}
