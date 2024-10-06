import 'package:basic_widgets/components/category_card.dart';
import 'package:basic_widgets/components/post_card.dart';
import 'package:basic_widgets/components/restaurant_landscape_card.dart';
import 'package:basic_widgets/components/theme_button.dart';
import 'package:basic_widgets/models/food_category.dart';
import 'package:basic_widgets/models/post.dart';
import 'package:basic_widgets/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'components/color_button.dart';
import 'constants.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.changeTheme,
    required this.changeColor,
    required this.colorSelected,
  });

  final void Function(bool useLightMode) changeTheme;
  final void Function(int value) changeColor;
  final ColorSelection colorSelected;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // TODO: Track current tab
  int tab = 0;

  // TODO: Define tab bar destinations
  List<NavigationDestination> appBarDestinations = const [
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: 'Category',
      selectedIcon: Icon(Icons.credit_card),
    ),
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: 'Post',
      selectedIcon: Icon(Icons.credit_card),
    ),
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: 'Restaurant',
      selectedIcon: Icon(Icons.credit_card),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: Define pages
    final pages = [
      // TODO: Replace with Category Card
      // 1
      Center(
        // 2
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          // 3
          child: CategoryCard(category: categories[0]),
        ),
      ),

      // TODO: Replace with Post Card
      Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PostCard(post: posts[0]),
        ),
      ),

      // TODO: Replace with Restaurant Landscape Card
      // 1
      Center(
        //2
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          // 3
          child: RestaurantLandscapeCard(
            restaurant: restaurants[0],
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          ThemeButton(
            changeThemeMode: widget.changeTheme,
          ),
          ColorButton(
            changeColor: widget.changeColor,
            colorSelected: widget.colorSelected,
          ),
        ],
      ),
      // TODO: Switch between pages
      body: IndexedStack(
        index: tab,
        children: pages,
      ),

      // TODO: Add bottom navigation bar
      // 1
      bottomNavigationBar: NavigationBar(
        // 2
        selectedIndex: tab,
        // 3
        onDestinationSelected: (index) {
          setState(() {
            tab = index;
          });
        },
        // 4
        destinations: appBarDestinations,
      ),
    );
  }
}
