import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashkey/provider/app_state_provider.dart';
import 'package:hashkey/provider/data_provider.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:hashkey/provider/user_provider.dart';
import 'package:hashkey/screens/authenticate.dart';
import 'package:hashkey/screens/create.dart';
import 'package:hashkey/screens/createpin.dart';
import 'package:hashkey/screens/home.dart';
import 'package:hashkey/screens/lists.dart';
import 'package:hashkey/screens/login.dart';
import 'package:hashkey/screens/option_selection.dart';
import 'package:hashkey/screens/search.dart';
import 'package:hashkey/screens/signup.dart';
import 'package:hashkey/screens/welcome.dart';
import 'package:hashkey/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  //  statusBarIconBrightness: Provider.of<UserProvider>(context, listen:false).theme == 'dark' ? Brightness.light : Brightness.dark
  ));

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? theme = prefs.getString('theme');
  theme ??= 'light';
  prefs.setString('theme', theme);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DataProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(theme.toString()))
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

    final theme = Provider.of<ThemeProvider>(context).theme;

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
      "/options":(context) => const OptionSelection(),
      "/options/create":(context) => const CreateNew(),
    };

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            MonthYearPickerLocalizations.delegate,
          ],
          title: 'Hashkey',
          theme: ThemeData(
            canvasColor: theme == 'dark' ? const Color.fromRGBO(42, 42, 42, 1) : const Color.fromRGBO(241, 240, 247, 1),
            textTheme: TextTheme(
              headlineLarge: TextStyle( color: theme == 'dark' ? Colors.white : Colors.black, letterSpacing: 2, fontSize: 25.sp, fontWeight: FontWeight.bold),
              headline1: TextStyle(
                color: theme == 'dark' ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
                letterSpacing: 2
              ),
              headline2: TextStyle(
                color: theme == 'dark' ? Colors.grey : Colors.black,
                fontSize: 20.sp,
              ),
              bodyText1: TextStyle(
                fontSize: 15.sp, 
                fontWeight: FontWeight.bold,
                color: theme == 'dark' ? Colors.white : Colors.black,
              ),
              subtitle1: TextStyle(
                color: theme == 'dark' ? Colors.grey : Colors.black,
                fontSize: 11.sp
              )
            ),
            scaffoldBackgroundColor: theme == 'dark' ? const Color.fromRGBO(42, 42, 42, 1) : const Color.fromRGBO(241, 240, 247, 1),
            fontFamily: GoogleFonts.poppins().fontFamily,
            iconTheme: IconThemeData(color: theme == 'light' ? Colors.grey : Colors.white),
          ),
          initialRoute: '/',
          onGenerateRoute: (settings){
            switch (settings.name) {
              case '/lists':
                return CupertinoPageRoute(builder: (context) => const Lists(), settings: settings);
              case '/options/create':
                return CupertinoPageRoute(builder: (context) => const CreateNew(), settings: settings);
              default:
                return CupertinoPageRoute(builder: (context) => routes[settings.name]!(context));
            }
          },
        );
      }
    );
  }
}
