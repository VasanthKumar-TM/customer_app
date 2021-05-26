// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:customer_app/screens/auth_screen.dart';
import 'package:customer_app/screens/cart_screen.dart';
import 'package:customer_app/screens/checkout_screen.dart';
import 'package:customer_app/screens/dish_info_screen.dart';
import 'package:customer_app/screens/get_started_screen.dart';
import 'package:customer_app/screens/history_screen.dart';
import 'package:customer_app/screens/home_screen.dart';
import 'package:customer_app/screens/orders_screen.dart';
import 'package:customer_app/screens/profile_screen.dart';
import 'package:customer_app/screens/search_screen.dart';
import 'package:customer_app/screens/splash_screen.dart';
import 'package:customer_app/pages/login_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    MaterialRoute(page: SplashScreen, initial: true),

    MaterialRoute(page: GetStartedScreen),
    MaterialRoute(page: LoginPage),
    MaterialRoute(page: HomeScreen),
    MaterialRoute(page: DishInfoScreen),
    MaterialRoute(page: ProfileScreen),
    MaterialRoute(page: CartScreen),
    MaterialRoute(page: CheckoutScreen),
    MaterialRoute(page: HistoryScreen),
    MaterialRoute(page: OrdersScreen),

    CustomRoute<bool>(
      page: SearchScreen,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
  ],
)
class $AppRouter {}
