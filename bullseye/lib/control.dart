import 'package:bullseye/game_model.dart';
import 'package:flutter/material.dart';

class Control extends StatefulWidget {
  const Control({
    super.key,
    required this.model,
  });

  final GameModel model;

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('1'),
        ),
        Expanded(
          child: Slider(
            value: widget.model.current.toDouble(),
            onChanged: (newValue) {
              setState(() {
                widget.model.current = newValue.toInt();
              });
            },
            min: 1.0,
            max: 100.0,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('100'),
        ),
      ],
    );
  }
}
