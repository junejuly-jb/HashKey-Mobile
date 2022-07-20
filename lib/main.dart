import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashkey/provider/app_state_provider.dart';
import 'package:hashkey/provider/data_provider.dart';
import 'package:hashkey/provider/user_provider.dart';
import 'package:hashkey/screens/authenticate.dart';
import 'package:hashkey/screens/createpin.dart';
import 'package:hashkey/screens/home.dart';
import 'package:hashkey/screens/lists.dart';
import 'package:hashkey/screens/login.dart';
import 'package:hashkey/screens/search.dart';
import 'package:hashkey/screens/signup.dart';
import 'package:hashkey/screens/welcome.dart';
import 'package:hashkey/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
     statusBarColor: Colors.transparent,
     statusBarIconBrightness: Brightness.dark
   ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DataProvider())
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var routes = {
      "/":(context) => const Wrapper(),
      "/login":(context) => const LoginPage(),
      "/signup":(context) => const SignUpScreen(),
      "/welcome":(context) => const WelcomeScreen(),
      "/home":(context) => const Home(),
      "/search":(context) => const SearchScreen(),
      "/lists":(context) => const Lists(),
      "/addPin":(context) => const CreatePin(),
      "/authenticate":(context) => const AuthenticateScreen(),
    };

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return MaterialApp(
          title: 'Hashkey',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: GoogleFonts.poppins().fontFamily
          ),
          initialRoute: '/',
          onGenerateRoute: (settings){
            switch (settings.name) {
              case '/lists':
                return CupertinoPageRoute(builder: (context) => const Lists(), settings: settings);
                
              default:
                return CupertinoPageRoute(builder: (context) => routes[settings.name]!(context));
               
            }
          },
        );
      }
    );
  }
}
