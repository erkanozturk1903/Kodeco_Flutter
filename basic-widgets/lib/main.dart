
import 'package:basic_widgets/components/color_button.dart';
import 'package:basic_widgets/components/theme_button.dart';
import 'package:basic_widgets/constants.dart';
import 'package:basic_widgets/home.dart';
import 'package:flutter/material.dart';

void main() {
  // 1
  runApp(const Yummy());
}

class Yummy extends StatefulWidget {

  const Yummy({super.key});

  @override
  State<Yummy> createState() => _YummyState();
}

class _YummyState extends State<Yummy> {
  // TODO: Setup default theme
  ThemeMode themeMode = ThemeMode.light;
 // Manual theme toggle
  ColorSelection colorSelected = ColorSelection.pink;

  // TODO: Add changeTheme above here
  void changeThemeMode(bool useLightMode) {
    setState(() {
      // 1
      themeMode = useLightMode
          ? ThemeMode.light //
          : ThemeMode.dark;
    });
  }

  void changeColor(int value) {
    setState(() {
      // 2
      colorSelected = ColorSelection.values[value];
    });
  }



  @override
  Widget build(BuildContext context) {
    const appTitle = 'Yummy';

    // TODO: Setup default theme

    //3
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      //debugShowCheckedModeBanner: false, // Uncomment to remove Debug banner

      // TODO: Add theme
      themeMode: themeMode,
      theme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),


      // TODO: Apply Home widget


      // 4
      home: Home(
      changeTheme: changeThemeMode,
      changeColor: changeColor,
      colorSelected: colorSelected,
    ),

    );
  }
}
