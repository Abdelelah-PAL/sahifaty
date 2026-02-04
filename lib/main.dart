import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
import 'screens/main_screen/main_screen.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'services/localization_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the LocalizationService before running the app
  await LocalizationService().init();
  Locale initialLocale = await LocalizationService.getCurrentLocale();

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
      child: MyApp(initialLocale: initialLocale),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;
  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GeneralController().checkConnectivity(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }

          if (snapshot.hasError) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }

          final hasConnection = snapshot.data ?? false;
          final generalProvider = Provider.of<GeneralProvider>(context);

          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            translations: LocalizationService(),
            locale: Get.locale ?? initialLocale,
            fallbackLocale: LocalizationService.fallbackLocale,
            themeMode: ThemeMode.light,
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
            ),
            home: hasConnection ? const SplashScreen() : const MainScreen(comesFirst: true),
          );
        });
  }
}
