import 'package:flutter/material.dart';
import '../../models/food_category.dart';

class CategoryCard extends StatelessWidget {
  // 1
  final FoodCategory category;

  const CategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Get text theme
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);


    // TODO: Replace with Card widget
    // 1
    return Card(
      // 2
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TODO: Add Stack Widget
          Stack(
            children: [
              // 1
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8.0)),
                child: Image.asset(category.imageUrl),
              ),
              // 2
              Positioned(
                left: 16.0,
                top: 16.0,
                child: Text(
                  'Yummy',
                  style: textTheme.headlineLarge,
                ),
              ),
              // 3
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'Smoothies',
                    style: textTheme.headlineLarge,
                  ),
                ),
              ),
            ],
          ),

          // TODO: Add ListTile widget
          ListTile(
            // 1
            title: Text(
              category.name,
              style: textTheme.titleSmall,),
            // 2
            subtitle: Text(
              '${category.numberOfRestaurants} places',
              style: textTheme.bodySmall,),),

        ],
      ),
    );
    // 2
  }
}
