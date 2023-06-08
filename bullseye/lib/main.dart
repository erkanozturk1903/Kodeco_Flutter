// ignore_for_file: avoid_print, unused_field

import 'package:bullseye/control.dart';
import 'package:bullseye/game_model.dart';
import 'package:bullseye/prompt.dart';
import 'package:bullseye/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    const BullsEyeApp(),
  );
}

class BullsEyeApp extends StatelessWidget {
  const BullsEyeApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return const MaterialApp(
      title: 'BullsEye',
      debugShowCheckedModeBanner: false,
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameModel _model;

  @override
  void initState() {
    super.initState();
    _model = GameModel(50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Prompt(
              targetValue: 100,
            ),
            Control(
              model: _model,
            ),
            TextButton(
              onPressed: () {
                //_alertIsVisible = true;
                _showAlert(context);
              },
              child: const Text(
                'Hit Me!',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            Score(
              totalScore: _model.totalScore,
              round: _model.round,
            )
          ],
        ),
      ),
    );
  }

  void _showAlert(BuildContext context) {
    var okButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        //_alertIsVisible = false;
        print('Awesome pressed!');
      },
      child: const Text('Awesone'),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Hello there!'),
            content: Text('The slider\'s value is ${_model.current}'),
            actions: [
              okButton,
            ],
            elevation: 5,
          );
        });
  }
}
