import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../../providers/users_provider.dart';
import '../../providers/evaluations_provider.dart';
import '../authentication_screens/login_screen.dart';
import '../sahifa_screen/sahifa_screen.dart';
import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    // Wait for a moment to show splash (optional, but good UX)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final evaluationsProvider = Provider.of<EvaluationsProvider>(context, listen: false);
    
    final bool isLoggedIn = await usersProvider.tryAutoLogin();

    if (isLoggedIn && usersProvider.selectedUser != null) {
      // If logged in, fetch necessary data (like evaluations)
      try {
        await evaluationsProvider.getQuranChartData(usersProvider.selectedUser!.id);
        Get.off(() => const SahifaScreen());
      } catch (e) {
         // Fallback to login if data fetch fails or token is invalid
         Get.off(() => const LoginScreen(firstScreen: true));
      }
    } else {
      Get.off(() => const LoginScreen(firstScreen: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: 150,
              height: 150,
            ),
             const SizedBox(height: 20),
             const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
