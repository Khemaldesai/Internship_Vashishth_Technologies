import 'package:expense/login_singup/login_page.dart';
import 'package:expense/login_singup/singup_page.dart';
import 'package:expense/navbar/about_us.dart';
import 'package:expense/navbar/analysis.dart';
import 'package:expense/navbar/faq.dart';
import 'package:expense/navbar/feedback.dart';
import 'package:expense/navbar/profile.dart';
import 'package:expense/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'google_sheets_api.dart';
import 'home_page.dart';

late Size mq;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetsApi().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => HomePage(),
        '/profile': (context) => Profile(),
        '/analysis': (context) => Analysis(),
        '/about_us': (context) => AboutUs(),
        '/feedback': (context) => FeedbackPage(),
        '/faq': (context) => FaqPage(),
      },
    );
  }
}
