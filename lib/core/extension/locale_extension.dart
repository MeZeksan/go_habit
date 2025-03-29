import 'package:flutter/material.dart';
import 'package:go_habit/l10n/app_localizations.dart';

extension LocaleExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
