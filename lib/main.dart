import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_player/Screen/HomeScreen/homeScreen.dart';
import 'package:mx_player/Screen/Song_Page/song_page.dart';
import 'package:mx_player/Screen/Splash/splash.dart';
import 'package:mx_player/mx_provider/provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'mx_provider/getxController.dart';
import 'search/search_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MusicProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );

  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: const ColorScheme.light(
            onPrimary: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.dark(
              onPrimary: Colors.white,
            )),
        themeMode: (theme1.value) ? ThemeMode.light : ThemeMode.dark,
        routes: {
          '/': (context) => SplashScreen(),
          '/home': (context) => const HomeScreen(),
          '/song': (context) => const SongPage(),
        },
      ),
    );
  }
}
