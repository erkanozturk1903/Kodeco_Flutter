import 'package:advance_interactive_widgets/components/item_details.dart';
import 'package:advance_interactive_widgets/screens/checkout_page.dart';
import 'package:flutter/material.dart';

import '../components/restaurant_item.dart';
import '../models/cart_manager.dart';
import '../models/order_manager.dart';
import '../models/restaurant.dart';

class RestaurantPage extends StatefulWidget {
  final Restaurant restaurant;
  final CartManager cartManager;
  final OrderManager ordersManager;

  const RestaurantPage({
    super.key,
    required this.restaurant,
    required this.cartManager,
    required this.ordersManager,
  });

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  static const double largeScreenPercentage = 0.9;
  static const double maxWidth = 1000;
  static const desktopThreshold = 700;
  // TODO: Define Drawer Max Width
  static const double drawerWidth = 375.0;

  // TODO: Define Scaffold Key
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  double _calculateConstrainedWidth(double screenWidth) {
    return (screenWidth > desktopThreshold
            ? screenWidth * largeScreenPercentage
            : screenWidth)
        .clamp(0.0, maxWidth);
  }

  int calculateColumnCount(double screenWidth) {
    const desktopThreshold = 700;
    return screenWidth > desktopThreshold ? 2 : 1;
  }

  CustomScrollView _buildCustomScrollView() {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(),
        _buildInfoSection(),
        _buildGridViewSection('Menu'),
      ],
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 300.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 64.0),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16.0),
                    image: DecorationImage(
                      image: AssetImage(widget.restaurant.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 0.0,
                  left: 16.0,
                  child: CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.store,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildInfoSection() {
    final textTheme = Theme.of(context).textTheme;
    final restaurant = widget.restaurant;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant.name,
              style: textTheme.headlineLarge,
            ),
            Text(
              restaurant.address,
              style: textTheme.bodySmall,
            ),
            Text(
              restaurant.getRatingAndDistance(),
              style: textTheme.bodySmall,
            ),
            Text(
              restaurant.attributes,
              style: textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }

  // TODO: Replace _buildGridItem()
  Widget _buildGridItem(int index) {
    final item = widget.restaurant.items[index];
    return InkWell(
      onTap: () => _showBottomSheet(item),
      child: RestaurantItem(item: item),
    );
  }


  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  GridView _buildGridView(int columns) {
    return GridView.builder(
      padding: const EdgeInsets.all(0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 3.5,
        crossAxisCount: columns,
      ),
      itemBuilder: (context, index) => _buildGridItem(index),
      itemCount: widget.restaurant.items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  SliverToBoxAdapter _buildGridViewSection(String title) {
    final columns = calculateColumnCount(MediaQuery.of(context).size.width);
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(title),
            _buildGridView(columns),
          ],
        ),
      ),
    );
  }

  // TODO: Show Bottom Sheet
  // 1
  void _showBottomSheet(Item item) {
    // 2
    showModalBottomSheet<void>(
      // 3
      isScrollControlled: true,
      // 4
      context: context,
      // 5
      constraints: const BoxConstraints(maxWidth: 480),
      // 6
      // TODO: Replace with Item Details Widget
      builder: (context) =>
          ItemDetails(
            item: item,
            cartManager: widget.cartManager,
            quantityUpdated: () {
              setState(() {});
            },
          ),

    );
  }

  // TODO: Create Drawer
  Widget _buildEndDrawer() {
    return SizedBox(
      width: drawerWidth,
      // TODO: Replace with Checkout Page
      // 1
      child: Drawer(
        // 2
        child: CheckoutPage(
          // 3
          cartManager: widget.cartManager,
          // 4
          didUpdate: () {
            setState(() {});
          },
          // 5
          onSubmit: (order) {
            widget.ordersManager.addOrder(order);
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),

    );
  }

  // TODO: Open Drawer
  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  // TODO: Create Floating Action Button
  // 1
  Widget _buildFloatingActionButton() {
    // 2
    return FloatingActionButton.extended(
      // 3
      onPressed: openDrawer,
      // 4
      tooltip: 'Cart',
      // 5
      icon: const Icon(Icons.shopping_cart),
      // 6
      label: Text('${widget.cartManager.items.length} Items in cart'),
    );
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final constrainedWidth = _calculateConstrainedWidth(screenWidth);

    return Scaffold(
      // TODO: Add Scaffold Key
      key: scaffoldKey,

      // TODO: Apply Drawer
      endDrawer: _buildEndDrawer(),

      // TODO: Apply Floating Action Button
      floatingActionButton: _buildFloatingActionButton(),

      body: Center(
        child: SizedBox(
          width: constrainedWidth,
          child: _buildCustomScrollView(),
        ),
      ),
    );
  }
}
