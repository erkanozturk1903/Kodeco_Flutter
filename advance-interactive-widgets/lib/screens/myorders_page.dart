import 'package:flutter/material.dart';
import '../models/order_manager.dart';

class MyOrdersPage extends StatelessWidget {
  final OrderManager orderManager;

  // 1
  const MyOrdersPage({
    super.key,
    required this.orderManager,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    // 2
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('My Orders', style: textTheme.headlineMedium),
      ),
      // 3
      body: ListView.builder(
        // 4
        itemCount: orderManager.totalOrders,
        itemBuilder: (context, index) {
          // 5
          return OrderTile(order: orderManager.orders[index]);
        },
      ),
    );
  }
}

// 6
class OrderTile extends StatelessWidget {
  final Order order;

  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    // 7
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        // 8
        child: Image.asset(
          'assets/food/burger.webp',
          width: 50.0,
          height: 50.0,
          fit: BoxFit.cover,
        ),
      ),
      // 9
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 10
          Text(
            'Scheduled',
            style: textTheme.bodyLarge,
          ),
          // 11
          Text(order.getFormattedOrderInfo()),
          // 12
          Text('Items: ${order.items.length}'),
        ],
      ),
    );
  }
}
