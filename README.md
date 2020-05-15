# virtual_mall

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

- Generate Funtional Widgets: Run Command [ref](https://github.com/rrousselGit/functional_widget)
    flutter pub pub run build_runner watch
    
- Generate App Translation: Run Commands [online documentation](https://proandroiddev.com/flutter-localization-step-by-step-30f95d06018d)
    flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/translation/l10n lib/translation/app_localizations.dart
    flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/translation/l10n    --no-use-deferred-loading lib/translation/app_localizations.dart lib/translation/l10n/intl_*.arb