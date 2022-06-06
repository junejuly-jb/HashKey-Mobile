import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/shared/bottom_appbar.dart';
import 'package:hashkey/shared/tabview/generate_screen.dart';
import 'package:hashkey/shared/tabview/main_screen.dart';
import 'package:hashkey/shared/tabview/qr_screen.dart';
import 'package:hashkey/shared/tabview/settings_screen.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String appState = 'home';

  void setAppState(String val){
    setState(() => appState = val,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 240, 247, 1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Builder(
            builder: (context){
              switch (appState) {
                case 'home':
                  return const Main();
                case 'generate':
                  return const GenerateScreen();
                case 'qrcode':
                  return const QrScreen();
                default:
                  return const SettingsScreen();
              }
            }
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Container(
          width: 60.w,
          height: 60.h,
          child: const Icon(
            Icons.add,
            size: 40,
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(106, 17, 203, 1),
                Color.fromRGBO(37, 117, 252, 1),
              ],
              begin: Alignment(-1, 1),
              end: Alignment(1, -1),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp
            ),
          ),
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomView(appState: appState, setAppState: setAppState),
    );
  }
}

