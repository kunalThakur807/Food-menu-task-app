import 'package:flutter/material.dart';
import 'package:task_app/utils/shimmer_effect.dart';

class FoodMenuShimmer extends StatelessWidget {
  const FoodMenuShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Access current theme

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
        centerTitle: true,
        title: Text("Our Menu", style: theme.appBarTheme.titleTextStyle),
        iconTheme: theme.appBarTheme.iconTheme,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ShimmerEffect.instance.foodMenuShimmer(),
        ),
      ),
    );
  }
}
