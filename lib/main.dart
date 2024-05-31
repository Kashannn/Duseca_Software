import 'package:dusecasoftware/utils/routes/routes.dart';
import 'package:dusecasoftware/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Bundy Track',
              initialRoute: RoutesName.signInScreen,
              onGenerateRoute: Routes.generateRoute,
            );
          },
        );
      },
    );
  }
}
