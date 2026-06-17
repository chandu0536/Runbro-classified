import 'package:flutter/material.dart';
import 'app_routes.dart';
import 'routes.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<T>? onGenerateRoute<T>(RouteSettings settings) {
    final name = settings.name ?? AppRoutes.splash;
    final args = settings.arguments;
    switch (name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen(), settings: settings);
      case AppRoutes.loading:
        return MaterialPageRoute(builder: (_) => const LoadingScreen(), settings: settings);
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen(), settings: settings);
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen(), settings: settings);
      case AppRoutes.otp:
        return MaterialPageRoute(builder: (_) => OtpScreen(phoneNumber: args as String? ?? ''), settings: settings);
      case AppRoutes.createAccount:
        return MaterialPageRoute(builder: (_) => CreateAccountScreen(phoneNumber: args as String? ?? ''), settings: settings);
      case AppRoutes.location:
        return MaterialPageRoute(builder: (_) => const LocationScreen(), settings: settings);
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen(), settings: settings);
      case AppRoutes.listings:
        return MaterialPageRoute(builder: (_) => ListingsScreen(category: args as String? ?? ''), settings: settings);
      case AppRoutes.listingDetail:
        return MaterialPageRoute(builder: (_) => const ListingDetailScreen(), settings: settings);
      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => const SearchScreen(), settings: settings);
      case AppRoutes.categories:
        return MaterialPageRoute(builder: (_) => const CategoriesScreen(), settings: settings);
      case AppRoutes.chats:
        return MaterialPageRoute(builder: (_) => const ChatsScreen(), settings: settings);
      case AppRoutes.chatDetail:
        return MaterialPageRoute(builder: (_) => args as Widget, settings: settings);
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen(), settings: settings);
      case AppRoutes.sell:
        return MaterialPageRoute(builder: (_) => const SellScreen(), settings: settings);
      case AppRoutes.myAds:
        return MaterialPageRoute(builder: (_) => const MyAdsScreen(), settings: settings);
      case AppRoutes.premium:
        return MaterialPageRoute(builder: (_) => const PremiumScreen(), settings: settings);
      case AppRoutes.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen(), settings: settings);
      case AppRoutes.wishlist:
        return MaterialPageRoute(builder: (_) => const WishlistScreen(), settings: settings);
      case AppRoutes.helpSupport:
        return MaterialPageRoute(builder: (_) => const HelpSupportScreen(), settings: settings);
      case AppRoutes.privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen(), settings: settings);
      case AppRoutes.termsConditions:
        return MaterialPageRoute(builder: (_) => const TermsConditionsScreen(), settings: settings);
      default:
        return MaterialPageRoute(builder: (_) => const LoadingScreen(), settings: settings);
    }
  }

  static void pushReplacement(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (_) => _routeWidget(routeName, arguments),
      settings: RouteSettings(name: routeName, arguments: arguments),
    ));
  }

  static void push(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => _routeWidget(routeName, arguments),
      settings: RouteSettings(name: routeName, arguments: arguments),
    ));
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static Widget _routeWidget(String routeName, Object? arguments) {
    switch (routeName) {
      case AppRoutes.splash:
        return const SplashScreen();
      case AppRoutes.loading:
        return const LoadingScreen();
      case AppRoutes.onboarding:
        return const OnboardingScreen();
      case AppRoutes.login:
        return const LoginScreen();
      case AppRoutes.otp:
        return OtpScreen(phoneNumber: arguments as String? ?? '');
      case AppRoutes.createAccount:
        return CreateAccountScreen(phoneNumber: arguments as String? ?? '');
      case AppRoutes.location:
        return const LocationScreen();
      case AppRoutes.home:
        return const HomeScreen();
      case AppRoutes.listings:
        return ListingsScreen(category: arguments as String? ?? '');
      case AppRoutes.listingDetail:
        return const ListingDetailScreen();
      case AppRoutes.search:
        return const SearchScreen();
      case AppRoutes.categories:
        return const CategoriesScreen();
      case AppRoutes.chats:
        return const ChatsScreen();
      case AppRoutes.chatDetail:
        return arguments as Widget;
      case AppRoutes.profile:
        return const ProfileScreen();
      case AppRoutes.sell:
        return const SellScreen();
      case AppRoutes.myAds:
        return const MyAdsScreen();
      case AppRoutes.premium:
        return const PremiumScreen();
      case AppRoutes.notifications:
        return const NotificationsScreen();
      case AppRoutes.wishlist:
        return const WishlistScreen();
      case AppRoutes.helpSupport:
        return const HelpSupportScreen();
      case AppRoutes.privacyPolicy:
        return const PrivacyPolicyScreen();
      case AppRoutes.termsConditions:
        return const TermsConditionsScreen();
      default:
        return const SplashScreen();
    }
  }
}
