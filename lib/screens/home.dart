
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/provider/data_provider.dart';
import 'package:hashkey/provider/user_provider.dart';
import 'package:hashkey/services/app.dart';
import 'package:hashkey/shared/tabview/credential_healthstat.dart';
import 'package:hashkey/shared/tabview/generate_screen.dart';
import 'package:hashkey/shared/tabview/main_screen.dart';
import 'package:hashkey/shared/tabview/qr_screen.dart';
import 'package:hashkey/shared/tabview/settings_screen.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {

  late bool isCardLoading;
  late bool isRecentLoading;
  late TabController controller = TabController(length: 5, vsync: this);
  int tabIndex = 0;
  
  @override
  void initState() {
    initCards();
    initRecents();
    controller.addListener((){
      setState(() => tabIndex = controller.index,);
    });
    super.initState();
  }

  Future initCards() async{
    isCardLoading = false;
    final data = Provider.of<DataProvider>(context, listen: false);
    if(data.cards.isEmpty){
      setState(() => isCardLoading = true,);
      Map result = await App().getCollectionLength();
      if(result['success']){
        data.setCards(result['categories']);
        setState(() => isCardLoading = false,);
      }
      else{
        setState(() => isCardLoading = false,);
      }
    }
  }


  Future initRecents() async{
    isRecentLoading = false;
    final data = Provider.of<DataProvider>(context, listen: false);
    if(data.recents.isEmpty){
      setState(() => isRecentLoading = true,);
      Map result = await App().getRecentList();
      if(result['success']){
        data.setRecents(result['data']);
        setState(() => isRecentLoading = false,);
      }
      else{
        setState(() => isRecentLoading = false,);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<UserProvider>(context).theme;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // For Android.
        // Use [light] for white status bar and [dark] for black status bar.
        statusBarIconBrightness: theme == 'dark' ? Brightness.light : Brightness.dark,
        // For iOS.
        // Use [dark] for white status bar and [light] for black status bar.
        statusBarBrightness: theme == 'dark' ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: TabBarView(
            controller: controller,
            children: [
              Main(isCardLoading: isCardLoading, isRecentLoading: isRecentLoading,),
              const GenerateScreen(),
              const CredentialHealthStatus(),
              const QrScreen(),
              const SettingsScreen()
            ],
          ),
        ),
        floatingActionButton: tabIndex == 0 ? FloatingActionButton(
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
                begin: const Alignment(-1, 1),
                end: const Alignment(1, -1),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp
              ),
            ),
          ),
          onPressed: () { 
            Navigator.pushNamed(context, '/options');
          },
        ) : null,
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(0,0,0,MediaQuery.of(context).padding.bottom),
          child: TabBar(
            indicatorColor: Colors.transparent,
            controller: controller,
            tabs: [
              Tab(icon: FaIcon(FontAwesomeIcons.house, color: tabIndex == 0 ? const Color.fromRGBO(106, 17, 203, 1) : Colors.grey,)),
              Tab(icon: FaIcon(FontAwesomeIcons.arrowsRotate, color: tabIndex == 1 ? const Color.fromRGBO(106, 17, 203, 1) : Colors.grey)),
              Tab(icon: FaIcon(FontAwesomeIcons.heartPulse, color: tabIndex == 2 ? const Color.fromRGBO(106, 17, 203, 1) : Colors.grey)),
              Tab(icon: FaIcon(FontAwesomeIcons.qrcode, color: tabIndex == 3 ? const Color.fromRGBO(106, 17, 203, 1) : Colors.grey)),
              Tab(icon: FaIcon(FontAwesomeIcons.gear, color: tabIndex == 4 ? const Color.fromRGBO(106, 17, 203, 1) : Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

