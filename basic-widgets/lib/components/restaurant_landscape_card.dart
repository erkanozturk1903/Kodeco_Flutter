import 'package:flutter/material.dart';

import '../models/restaurant.dart';

class RestaurantLandscapeCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantLandscapeCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TODO: Add Image
          ClipRRect(
            // 1
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(8.0),
            ),
            // 2
            child: AspectRatio(
              aspectRatio: 2,
              child: Image.asset(
                restaurant.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // TODO: Add ListTile
          ListTile(
            // 1
            title: Text(
              restaurant.name,
              style: textTheme.titleSmall,
            ),
            // 2
            subtitle: Text(
              restaurant.attributes,
              maxLines: 1,
              style: textTheme.bodySmall,
            ),
            // 3
            onTap: () {
              // ignore: avoid_print
              print('Tap on ${restaurant.name}');
            },
          ),
        ],
      ),
    );
  }
}
