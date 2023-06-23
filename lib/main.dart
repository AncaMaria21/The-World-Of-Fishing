import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_fish/services/firebase_service.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app_setup.locator.dart';
import 'app/app_setup.router.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key'
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: "FlutterPhoneAuth",
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
      ),
    );
    //   MaterialApp(
    //   title: "FlutterPhoneAuth",
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //     visualDensity: VisualDensity.adaptivePlatformDensity
    //   ),
    //   navigatorKey: StackedService.navigatorKey,
    //   onGenerateRoute: StackedRouter().onGenerateRoute,
    // );
  }
}

