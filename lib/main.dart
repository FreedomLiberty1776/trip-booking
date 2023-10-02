import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip_booking/pages/home.dart';
import 'package:trip_booking/pages/preload_screen.dart';
import 'package:trip_booking/pages/update_profile.dart';
import 'package:trip_booking/pages/verify_phone.dart';
import 'package:provider/provider.dart';
import 'package:trip_booking/utils/navigator_service.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/app_controller.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Booking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        // designSize: const Size(360, 690),
        builder: (BuildContext context, Widget? child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => AppControllerNotifer()),
              ],
              child: MaterialApp(
                navigatorKey: NavigationService.navigatorKey, // set property

                debugShowCheckedModeBanner: false,
                title: 'title',
                theme: ThemeData(
                  textSelectionTheme: const TextSelectionThemeData(
                      // selectionHandleColor: Colors.transparent,
                      ),
                  appBarTheme: const AppBarTheme(
                    // shadowColor: Colors.transparent,
                    backgroundColor: Colors.white,
                  ),
                  colorScheme: const ColorScheme(
                    background: Colors.white,
                    onBackground: Color(0xff212b9e),
                    //
                    primary: Color(0xff212b9e),
                    onPrimary: Color(0xff212b9e),

                    ///
                    secondary: Color(0xffeec6d5),
                    onSecondary: Colors.white,
                    //
                    surface: Colors.white,
                    onSurface: Colors.black,
                    //
                    error: Color(0xff212b9e),
                    onError: Colors.white,
                    //
                    brightness: Brightness.light,
                    // all fields should have a value
                  ),
                  textTheme:
                      Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
                ),

                initialRoute: '/',
                routes: {
                  '/': (context) => const Preload(),
                  '/verify_phone': (context) => const VerifyNumber(
                        actionRoute: 'none',
                      ),
                  "/home": (context) => const Home(),
                  '/update_profile': (context) => UpdateProfile(),
                },
              ));
        },
      );
}
