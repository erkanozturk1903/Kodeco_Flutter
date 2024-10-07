import 'package:flutter/material.dart';

// 1
class CartControl extends StatefulWidget {
  // 2
  final void Function(int) addToCart;

  const CartControl({
    required this.addToCart,
    super.key,
  });

  // 3
  @override
  State<CartControl> createState() => _CartControlState();
}

// 4
class _CartControlState extends State<CartControl> {
  // 5
  int _cartNumber = 1;

  @override
  Widget build(BuildContext context) {
    // 6
    final colorScheme = Theme.of(context).colorScheme;
    // 7
    return Row(
      // 8
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // 9
      children: [
        // TODO: Add Cart Control Components
        _buildMinusButton(),
        _buildCartNumberContainer(colorScheme),
        _buildPlusButton(),
        const Spacer(),
        _buildAddCartButton(),

      ],
    );
  }

// TODO: Build Minus Button
// 1
  Widget _buildMinusButton() {
    // 2
    return IconButton(
      icon: const Icon(Icons.remove),
      // 3
      onPressed: () {
        setState(() {
          // 4
          if (_cartNumber > 1) {
            _cartNumber--;
          }
        });
      },
      // 5
      tooltip: 'Decrease Cart Count',
    );
  }

// TODO: Build Cart Number
// 1
  Widget _buildCartNumberContainer(ColorScheme colorScheme) {
    // 2
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: colorScheme.onPrimary,
      // 3
      child: Text(_cartNumber.toString()),
    );
  }

// TODO: Build Plus Button
  Widget _buildPlusButton() {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        setState(() {
          _cartNumber++;
        });
      },
      tooltip: 'Increase Cart Count',
    );
  }

// TODO: Build Add Cart Button
  Widget _buildAddCartButton() {
    // 1
    return FilledButton(
      // 2
      onPressed: () {
        widget.addToCart(_cartNumber);
      },
      // 3
      child: const Text('Add to Cart'),
    );
  }

}
