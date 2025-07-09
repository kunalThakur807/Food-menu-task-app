import 'package:flutter/material.dart';

import 'screen_export.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.foodMenuScreenRoute:
      return MaterialPageRoute(builder: (context) => const FoodMenuScreen());
    case Routes.cartScreenRoute:
      return MaterialPageRoute(builder: (context) => const CartScreen());
    default:
      return MaterialPageRoute(
        // Make a screen for undefine
        builder: (context) => const FoodMenuScreen(),
      );
  }
}
