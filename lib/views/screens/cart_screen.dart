import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/controllers/cart_controller.dart';
import 'package:task_app/services/notification_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0.2,
        centerTitle: true,
        title: Text(
          "My Cart",
          style:
              theme.appBarTheme.titleTextStyle ??
              theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Obx(() {
        final cartItems = cartController.cartItems;
        final subtotal = cartController.totalPrice;

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: cartItems.length,
                separatorBuilder:
                    (_, __) => Divider(height: 1, color: theme.dividerColor),
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                  final item = cartItem.item;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: item.menuImage,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                            placeholder:
                                (_, __) => Container(
                                  height: 60,
                                  width: 60,
                                  color: theme.colorScheme.surfaceVariant,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                            errorWidget:
                                (_, __, ___) => Container(
                                  height: 60,
                                  width: 60,
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.5),
                                  child: const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.disName,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "₹${item.mediumPrice.toStringAsFixed(2)} x ${cartItem.quantity} = ₹${(item.mediumPrice * cartItem.quantity).toStringAsFixed(2)}",
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed:
                                  () =>
                                      cartController.decreaseQuantity(cartItem),
                              icon: Icon(
                                Icons.remove_circle_outline,
                                color: theme.iconTheme.color,
                              ),
                            ),
                            Text(
                              cartItem.quantity.toString().padLeft(2, '0'),
                              style: theme.textTheme.bodyMedium,
                            ),
                            IconButton(
                              onPressed:
                                  () =>
                                      cartController.increaseQuantity(cartItem),
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: theme.iconTheme.color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(thickness: 1, color: theme.dividerColor),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  priceRow(context, "Subtotal", subtotal),
                  priceRow(context, "Shipping Cost", 0.0),
                  const SizedBox(height: 8),
                  priceRow(context, "Total Cost", subtotal, isTotal: true),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (cartController.cartItems.isEmpty) {
                          Get.snackbar(
                            "Cart is empty",
                            "Please add items before placing an order.",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 2),
                            margin: const EdgeInsets.all(12),
                          );
                          return;
                        }

                        await NotificationService()
                            .showOrderPlacedNotification();
                        Get.snackbar(
                          "Order Placed",
                          "Your order has been successfully placed.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 2),
                          margin: const EdgeInsets.all(12),
                          icon: const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                        );

                        cartController.cartItems.clear();
                      },

                      child: Text("Place Order"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget priceRow(
    BuildContext context,
    String label,
    double value, {
    bool isTotal = false,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            "₹${value.toStringAsFixed(2)}",
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
