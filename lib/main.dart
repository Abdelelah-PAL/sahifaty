import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'controllers/general_controller.dart';
import 'core/constants/colors.dart';
import 'providers/ayat_provider.dart';
import 'providers/evaluations_provider.dart';
import 'providers/general_provider.dart';
import 'providers/school_provider.dart';
import 'providers/surahs_provider.dart';
import 'providers/users_provider.dart';
import 'screens/authentication_screens/login_screen.dart';
import 'screens/main_screen/main_screen.dart';

import 'screens/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeneralProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => SchoolProvider()),
        ChangeNotifierProvider(create: (_) => AyatProvider()),
        ChangeNotifierProvider(create: (_) => EvaluationsProvider()),
        ChangeNotifierProvider(create: (_) => SurahsProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GeneralController().checkConnectivity(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if ((snapshot.hasError)) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }
          // The network check is good, but for offline support (if desired later) or just basic app start,
          // we might want to go to Splash regardless of connectivity, 
          // but if the app strictly requires internet, then checking it here is fine.
          // However, we want to check SESSION first.
          // So let's route to SplashScreen which handles logic.
          // Does SplashScreen need connectivity? It calls getQuranChartData which likely does.
          // So maybe clear connectivity check or move it?
          // The current code wraps everything in FutureBuilder<checkConnectivity>.
          // If hasConnection is true, it goes to Login or Main.
          // I will change it to go to SplashScreen.
          
          final hasConnection = snapshot.data ?? false;
           
           final generalProvider = Provider.of<GeneralProvider>(context);

           return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: generalProvider.themeMode,
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.backgroundColor,
                brightness: Brightness.light,
                textTheme: const TextTheme(
                   bodyLarge: TextStyle(color: AppColors.blackFontColor),
                ),
                colorScheme: const ColorScheme.light(
                  surface: AppColors.backgroundColor,
                  primary: AppColors.backgroundColor,
                  secondary: AppColors.buttonColor,
                ),
              ),
              darkTheme: ThemeData(
                scaffoldBackgroundColor: const Color(0xFF121212),
                brightness: Brightness.dark,
                 textTheme: const TextTheme(
                   bodyLarge: TextStyle(color: Colors.white),
                ),
                 colorScheme: const ColorScheme.dark(
                  surface: Color(0xFF1E1E1E),
                   primary: Color(0xFF121212),
                  secondary: AppColors.buttonColor,
                ),
               // iconTheme: const IconThemeData(color: Colors.white),
              ),
              home:
                  hasConnection ? const SplashScreen() : const MainScreen(comesFirst: true,));
        });
  }
}
