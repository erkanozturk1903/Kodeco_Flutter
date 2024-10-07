// 1
import 'package:advanced_scrollable_widgets/components/restaurant_item.dart';
import 'package:flutter/material.dart';
import '../models/restaurant.dart';

// 2
class RestaurantPage extends StatefulWidget {
  final Restaurant restaurant;

  // 3
  const RestaurantPage({
    super.key,
    required this.restaurant,
  });

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

// 4
class _RestaurantPageState extends State<RestaurantPage> {
  // TODO: Add Desktop Threshold
  static const desktopThreshold = 700;
  // TODO: Add Constraint Properties
  static const double largeScreenPercentage = 0.9;
  static const double maxWidth = 1000;

  // TODO: Calculate Constrained Width
  double _calculateConstrainedWidth(double screenWidth) {
    return (screenWidth > desktopThreshold
        ? screenWidth * largeScreenPercentage //
        : screenWidth)
        .clamp(0.0, maxWidth);
  }

  // TODO: Add Calculate Column Count
  int calculateColumnCount(double screenWidth) {
    return screenWidth > desktopThreshold ? 2 : 1;
  }

  // TODO: Build Custom Scroll View
  CustomScrollView _buildCustomScrollView() {
    return CustomScrollView(
      slivers: [
        // TODO: Add Sliver App Bar
        _buildSliverAppBar(),

        // TODO: Add Restaurant Info Section
        _buildInfoSection(),

        // TODO: Add Menu Item Grid View Section
        _buildGridViewSection('Menu'),

      ],
    );
  }

  // TODO: Build Sliver App Bar
  SliverAppBar _buildSliverAppBar() {
    // 1
    return SliverAppBar(
      // 2
      pinned: true,
      // 3
      expandedHeight: 300.0,
      // 4
      flexibleSpace: FlexibleSpaceBar(
        // 5
        background: Center(
          // 6
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 64.0,
            ),
            // 7
            child: Stack(
              children: [
                // 8
                Container(
                  margin: const EdgeInsets.only(bottom: 30.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16.0),
                    // 9
                    image: DecorationImage(
                      image: AssetImage(widget.restaurant.imageUrl),
                      fit: BoxFit.cover,),),
                ),
                // 10
                const Positioned(
                  bottom:0.0,
                  left: 16.0,
                  child: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.store, color: Colors.white,),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TODO: Build Info Section
  // 1
  SliverToBoxAdapter _buildInfoSection() {
    // 2
    final textTheme = Theme.of(context).textTheme;
    // 3
    final restaurant = widget.restaurant;
    // 4
    return SliverToBoxAdapter(
      // 5
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        // 6
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 7
            Text(restaurant.name, style: textTheme.headlineLarge,),
            Text(restaurant.address, style: textTheme.bodySmall,),
            Text(
              restaurant.getRatingAndDistance(),
              style: textTheme.bodySmall,),
            Text(restaurant.attributes, style: textTheme.labelSmall,),
          ],
        ),
      ),
    );
  }

  // TODO: Build Grid Item
  Widget _buildGridItem(int index) {
    final item = widget.restaurant.items[index];
    return InkWell(
      onTap: () {
        // Present Bottom Sheet in the future.
      },
      child: RestaurantItem(item: item),
    );
  }

  // TODO: Build Section Title
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,),
      ),
    );
  }

  // TODO: Build Grid View
  // 1
  GridView _buildGridView(int columns) {
    // 2
    return GridView.builder(
      padding: const EdgeInsets.all(0),
      // 3
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 3.5,
        crossAxisCount: columns,
      ),
      // 4
      itemBuilder: (context, index) => _buildGridItem(index),
      // 5
      itemCount: widget.restaurant.items.length,
      // 6
      shrinkWrap: true,
      // 7
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  // TODO: Build Grid View Section
// 1
  SliverToBoxAdapter _buildGridViewSection(String title) {
    // 2
    final columns = calculateColumnCount(MediaQuery.of(context).size.width);
    // 3
    return SliverToBoxAdapter(
      // 4
      child: Container(
        padding: const EdgeInsets.all(16.0),
        // 5
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 6
            _sectionTitle(title),
            // 7
            _buildGridView(columns),
          ],
        ),
      ),
    );
  }

  // TODO: Replace build method
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final constrainedWidth = _calculateConstrainedWidth(screenWidth);

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: constrainedWidth,
          child: _buildCustomScrollView(),
        ),
      ),
    );
  }

}
