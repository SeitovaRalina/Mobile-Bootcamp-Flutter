// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'FakeStore';

  @override
  String get retry => 'Retry';

  @override
  String get errorUnknown => 'Something went wrong';

  @override
  String get errorNetwork => 'No internet connection';

  @override
  String get errorServer => 'Server error. Please try again later';

  @override
  String get errorCache => 'Storage error';

  @override
  String get success => 'Success';

  @override
  String get ok => 'OK';

  @override
  String get navHome => 'Home';

  @override
  String get navCart => 'Cart';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navProfile => 'Profile';

  @override
  String get homeTabHome => 'Home';

  @override
  String get homeTabCategory => 'Category';

  @override
  String get homeRecommendedProducts => 'Recommended products';

  @override
  String get homeExplore => 'Explore';

  @override
  String get homeNoProductsInCategory => 'No products found in this category';

  @override
  String get detailsDescription => 'Description';

  @override
  String get detailsAddToCart => 'Add to Cart';

  @override
  String get detailsViewCart => 'View Cart';

  @override
  String get cartMyCart => 'My Cart';

  @override
  String get cartEmpty => 'Your cart is empty';

  @override
  String get cartTotal => 'Total:';

  @override
  String get cartCheckout => 'Checkout';

  @override
  String get cartOrderPlaced => 'Order placed successfully!';

  @override
  String get favoritesTitle => 'My Favorites';

  @override
  String get favoritesEmpty => 'No favorites yet';

  @override
  String get profileTitle => 'My Profile';

  @override
  String get profileDemoName => 'FakeStore Demo';

  @override
  String get profileDevInfo => 'Student Labs 2026 • Mobile Bootcamp';

  @override
  String get profileAppearance => 'Appearance';

  @override
  String get profileThemeSystem => 'System';

  @override
  String get profileThemeLight => 'Light';

  @override
  String get profileThemeDark => 'Dark';

  @override
  String get profileAboutApp => 'About this app';

  @override
  String get profileAboutDescription =>
      'This application was created as a practical project during the Flutter Mobile Development Bootcamp organized by Student Labs in 2026.\n\nThe main goal is to help beginners master clean architecture, state management (Bloc/Cubit), working with APIs, theming and navigation in real-world-like e-commerce application.';

  @override
  String profileVersion(Object version) {
    return 'v$version (Student Labs Bootcamp Edition)';
  }
}
