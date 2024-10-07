import 'dart:ui';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'home.dart';
import '../models/models.dart';
import 'screens/screens.dart';
import 'package:go_router/go_router.dart';


void main() {
  runApp(const Yummy());
}

/// Allows the ability to scroll by dragging with touch, mouse, and trackpad.
class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad
      };
}

class Yummy extends StatefulWidget {
  const Yummy({super.key});

  @override
  State<Yummy> createState() => _YummyState();
}

class _YummyState extends State<Yummy> {
  ThemeMode themeMode = ThemeMode.light;
  ColorSelection colorSelected = ColorSelection.pink;

  /// Authentication to manage user login session
  // ignore: unused_field
  final YummyAuth _auth = YummyAuth();

  /// Manage user's shopping cart for the items they order.
  final CartManager _cartManager = CartManager();

  /// Manage user's orders submitted
  final OrderManager _orderManager = OrderManager();

  // TODO: Initialize GoRouter
  // 1
  late final _router = GoRouter(
    // 2
    initialLocation: '/login',
    // TODO: Add App Redirect
    redirect: _appRedirect,

    // 3
    routes: [
      // TODO: Add Login Route
      GoRoute(
        // 1
          path: '/login',
          // 2
          builder: (context, state) =>
          // 3
          LoginPage(
            // 4
              onLogIn: (Credentials credentials) async {
                // 5
                _auth
                    .signIn(credentials.username, credentials.password)
                // 6
                    .then((_) => context.go('/${YummyTab.home.value}'));
              },),),

      // TODO: Add Home Route
      // 1
      GoRoute(
          path: '/:tab',
          builder: (context, state) {
            // 2
            return Home(
              //3
                auth: _auth,
                //4
                cartManager: _cartManager,
                //5
                ordersManager: _orderManager,
                //6
                changeTheme: changeThemeMode,
                //7
                changeColor: changeColor,
                //8
                colorSelected: colorSelected,
                //9
                tab: int.tryParse(state.pathParameters['tab'] ?? '') ?? 0);
          },
          // 10
          routes: [
            // TODO: Add Restaurant Route
            GoRoute(
              // 1
                path: 'restaurant/:id',
                builder: (context, state) {
                  // 2
                  final id =
                      int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
                  // 3
                  final restaurant = restaurants[id];
                  // 4
                  return RestaurantPage(
                    restaurant: restaurant,
                    cartManager: _cartManager,
                    ordersManager: _orderManager,
                  );
                }),

          ]),

    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(
              state.error.toString(),
            ),
          ),
        ),
      );
    },

  );


  // TODO: Add Redirect Handler
  // 1
  Future<String?> _appRedirect(
      BuildContext context, GoRouterState state) async {
    // 2
    final loggedIn = await _auth.loggedIn;
    // 3
    final isOnLoginPage = state.matchedLocation == '/login';

    // 4
    // Go to /login if the user is not signed in
    if (!loggedIn) {
      return '/login';
    }
    // 5
    // Go to root if the user is already signed in
    else if (loggedIn && isOnLoginPage) {
      return '/${YummyTab.home.value}';
    }

    // 6
    // no redirect
    return null;
  }


  void changeThemeMode(bool useLightMode) {
    setState(() {
      themeMode = useLightMode
          ? ThemeMode.light //
          : ThemeMode.dark;
    });
  }

  void changeColor(int value) {
    setState(() {
      colorSelected = ColorSelection.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with Router
    // 1
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // 2
      routerConfig: _router,
      // TODO: Add Custom Scroll Behavior
      title: 'Yummy',
      scrollBehavior: CustomScrollBehavior(),
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
    );

  }
}
