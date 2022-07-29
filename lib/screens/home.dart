
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/provider/app_state_provider.dart';
import 'package:hashkey/provider/data_provider.dart';
import 'package:hashkey/services/app.dart';
import 'package:hashkey/shared/tabview/generate_screen.dart';
import 'package:hashkey/shared/tabview/main_screen.dart';
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
  late TabController controller = TabController(length: 3, vsync: this);

  

  @override
  void initState() {
    initCards();
    initRecents();
    controller.addListener((){
        print(controller.index);
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
    final app = Provider.of<AppStateProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 240, 247, 1),
      body: SafeArea(
        child: TabBarView(
          controller: controller,
          children: [
            Main(isCardLoading: isCardLoading, isRecentLoading: isRecentLoading,),
            const GenerateScreen(),
            const SettingsScreen()
          ],
        ),
      ),
      floatingActionButton: app.appState == 'home' ? FloatingActionButton(
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
        onPressed: () { 
          Navigator.pushNamed(context, '/options');
        },
      ) : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: TabBar(
        controller: controller,
        tabs: const  [
          Tab(icon: Icon(FontAwesomeIcons.house)),
          Tab(icon: Icon(Icons.directions_transit)),
          Tab(icon: Icon(Icons.directions_bike)),
        ],
      ),
    );
  }
}

