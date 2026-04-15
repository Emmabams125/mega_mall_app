import 'dart:developer' as dev;
import 'package:ecommerce_app/styles/theme_data.dart';
import 'package:ecommerce_app/app/app_pages.dart';
import 'package:ecommerce_app/app/route_names.dart';
import 'package:ecommerce_app/app/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  dev.log('🚀 APP STARTING...', name: 'APP');

  WidgetsFlutterBinding.ensureInitialized();
  dev.log('📱 WidgetsFlutterBinding initialized', name: 'APP');

  await Hive.initFlutter();
  dev.log('🐝 Hive initialized', name: 'APP');

  await setupLocator();
  dev.log('🔗 Dependency injection setup complete', name: 'APP');

  runApp(const MyApp());
  dev.log('✅ App running', name: 'APP');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-COMMERCE',
          initialRoute: Routes.splashScreen,
          getPages: AppPages.routes,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(1.0)),
              child: widget!,
            );
          },
        );
      },
    );
  }
}
