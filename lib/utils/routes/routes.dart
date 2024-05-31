
import 'package:dusecasoftware/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../views/signin_screen.dart';
import '../../views/signup_screen.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.signInScreen:
        return MaterialPageRoute(builder: (_) =>const SignIn());
      case RoutesName.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUp ());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
