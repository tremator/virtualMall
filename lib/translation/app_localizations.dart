import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtual_mall/translation/l10n/messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
    locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get quotationTitle {
    return Intl.message('Quotation', name: 'quotationTitle');
  }

  String get call {
    return Intl.message('Call', name: 'call');
  }

  String get all {
    return Intl.message('All', name: 'all');
  }

  String get notProducts {
    return Intl.message('No Products Here', name: 'notProducts');
  }

  String get characteristics {
    return Intl.message('Characteristics', name: 'characteristics');
  }

  String get foods {
    return Intl.message('Foods', name: 'foods');
  }

  String get foodTypes {
    return Intl.message('Foods Types', name: 'foodTypes');
  }

  String get photo {
    return Intl.message('Photo', name: 'photo');
  }

  String get associatedBusiness {
    return Intl.message('Associated Business', name: 'associatedBusiness');
  }

  String get signIn {
    return Intl.message('SignIn', name: 'signIn');
  }

  String get typeMessage {
    return Intl.message('Type your message...', name: 'typeMessage');
  }

  String get showProducts {
    return Intl.message('Show Products', name: 'showProducts');
  }

  String get details {
    return Intl.message('Details', name: 'details');
  }

  String get welcome {
    return Intl.message('Welcome', name: 'welcome');
  }

  String get createLegend {
    return Intl.message('Create an account to make express purchases and much more', name: 'createLegend');
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}