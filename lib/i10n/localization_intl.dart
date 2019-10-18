import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

///
/// Created by dumingwei on 2019-10-15.
/// Desc:
///

class IntlDemoLocalizations {
  static Future<IntlDemoLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    print('IntlDemoLocalizations localeName = $localeName');

    return initializeMessages(localeName).then((oldValue) {
      Intl.defaultLocale = localeName;
      return new IntlDemoLocalizations();
    });
  }

  static IntlDemoLocalizations of(BuildContext context) {
    return Localizations.of<IntlDemoLocalizations>(
        context, IntlDemoLocalizations);
  }

  String get title {
    return Intl.message(
      'Flutter APP',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }
}

class IntlDemoLocalizationsDelegate
    extends LocalizationsDelegate<IntlDemoLocalizations> {
  const IntlDemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    print(
        'IntlDemoLocalizationsDelegate  isSupported locale.languageCode = ${locale.languageCode}');
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  bool shouldReload(LocalizationsDelegate<IntlDemoLocalizations> old) {
    return false;
  }

  @override
  Future<IntlDemoLocalizations> load(Locale locale) {
    return IntlDemoLocalizations.load(locale);
  }
}
