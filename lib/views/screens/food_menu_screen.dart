import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/controllers/cart_controller.dart';
import 'package:task_app/controllers/food_menu_controller.dart';
import 'package:task_app/route/route_constants.dart';
import 'package:task_app/services/theme_service.dart';
import 'package:task_app/utils/shimmer_effect.dart';
import 'package:task_app/views/widgets/food_menu_shimmer.dart';
import 'package:task_app/views/widgets/menu_item_card.dart';

class FoodMenuScreen extends StatefulWidget {
  const FoodMenuScreen({super.key});

  @override
  State<FoodMenuScreen> createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  late AnimationController _cartAnimationController;

  @override
  void initState() {
    super.initState();
    _cartAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 1.0,
      upperBound: 1.4,
    );
  }

  void _playCartAnimation() {
    _cartAnimationController.forward().then((_) {
      _cartAnimationController.reverse();
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _cartAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FoodMenuController>();
    final cartController = Get.find<CartController>();
    final theme = Theme.of(context);

    return Obx(() {
      if (controller.loading.value) {
        return FoodMenuShimmer();
      }

      if (controller.menuGroups.isEmpty) {
        return Scaffold(
          body: Center(
            child: Text(
              "No menu items found",
              style: theme.textTheme.bodyMedium,
            ),
          ),
        );
      }

      final categories =
          controller.menuGroups
              .map((group) => group.isNotEmpty ? group[0].groupName : "Unknown")
              .toList();

      if (_tabController == null ||
          _tabController!.length != controller.menuGroups.length) {
        _tabController?.dispose();
        _tabController = TabController(
          length: controller.menuGroups.length,
          vsync: this,
        );
      }

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text("Our Menu", style: theme.appBarTheme.titleTextStyle),
          actions: [
            IconButton(
              icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => ThemeService().switchTheme(),
            ),
            Obx(() {
              return ScaleTransition(
                scale: _cartAnimationController,
                child: Stack(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: theme.iconTheme.color,
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.cartScreenRoute);
                      },
                    ),
                    if (cartController.cartItems.isNotEmpty)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.primary,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            cartController.cartItems.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ],
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: theme.colorScheme.primary,
            labelColor: theme.colorScheme.primary,
            unselectedLabelColor: theme.textTheme.bodyMedium?.color
                ?.withOpacity(0.6),
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: categories.map((title) => Tab(text: title)).toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children:
              controller.menuGroups.map((groupItems) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                    itemCount: groupItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 2.5 / 4,
                        ),
                    itemBuilder: (context, index) {
                      final item = groupItems[index];
                      return MenuItemCard(
                        item: item,
                        onAddToCart: _playCartAnimation,
                      );
                    },
                  ),
                );
              }).toList(),
        ),
      );
    });
  }
}
