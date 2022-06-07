import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashkey/screens/home.dart';
import 'package:hashkey/screens/login.dart';
import 'package:hashkey/screens/search.dart';
import 'package:hashkey/screens/signup.dart';
import 'package:hashkey/screens/welcome.dart';

void main() {
   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
     statusBarColor: Colors.transparent,
     statusBarIconBrightness: Brightness.dark
   ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return MaterialApp(
          title: 'Hashkey',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: GoogleFonts.poppins().fontFamily
          ),
          initialRoute: '/welcome',
          routes: {
            "/login":(context) => const LoginPage(),
            "/signup":(context) => const SignUpScreen(),
            "/welcome":(context) => const WelcomeScreen(),
            "/home":(context) => const Home(),
            "/search":(context) => const SearchScreen(),
          },
        );
      }
    );
  }
}
