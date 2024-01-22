import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:spendwise/core/constants/constant_widgets/bottom_nav.dart';
import 'package:spendwise/src/page/splash_page.dart';
import 'package:spendwise/core/constants/route.dart';
import 'package:spendwise/services/models/budgets/budget_data.dart';
import 'package:spendwise/services/models/expense/expense_data.dart';
import 'package:spendwise/src/page/budget_fab_page.dart';
import 'package:spendwise/src/page/budget_two_fab_page.dart';
import 'package:spendwise/src/page/fab_page.dart';
import 'package:spendwise/src/page/forgotten_password_page.dart';
import 'package:spendwise/src/page/home_page.dart';
import 'package:spendwise/src/page/login_page.dart';
import 'package:spendwise/src/page/signup_page.dart';
import 'package:spendwise/src/page/summary_page.dart';
import 'package:spendwise/src/page/verify_page.dart';
import 'package:spendwise/services/api/firebase_api/firebase_api.dart';
import 'package:spendwise/services/auth/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox("budget_database");

  await Hive.openBox('expense_database');

  await AuthService.firebase().initialize();

  await FirebasePushNotificationApi().initNotification();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BudgetData(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExpenseData(),
        )
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Roboto',
          primarySwatch: Colors.grey,
        ),
        routes: {
          loginRoute: (context) => const LoginPage(),
          signupRoute: (context) => const SignUpPage(),
          homeRoute: (context) => const HomePage(),
          verifyRoute: (context) => const VerifyPage(),
          fabRoute: (context) => const FabPage(),
          budgetFabRoute: (context) => const BudgetFabPage(),
          summaryRoute: (context) => const SummaryPage(),
          forgotPasswordRoute: (context) => const ForgotPasswordPage(),
          budgetTwoFabRoute: (context) => const BudgetTwoFabPage(),
          splashRoute: (context) => const SplashPage(),
          homeMainRoute: (context) => const HomeMain(),
          bottomNavigationRoute: (context) => const BottomNavBar(),
        },
        home: const SplashPage(),
      ),
    );

    // ChangeNotifierProvider(
    //   create: (context) => BudgetData(),
    //   builder: (context, child) =>
    // );
  }
}

class HomeMain extends StatelessWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const BottomNavBar();
              } else {
                return const VerifyPage();
              }
            } else {
              return const LoginPage();
            }
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}

// void main() {
//   runApp(ProviderScope(child: MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Drop Down List',
//       darkTheme: ThemeData.dark(),
//       themeMode: ThemeMode.dark,
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
