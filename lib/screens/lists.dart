import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/lists/password_list.dart';
import 'package:hashkey/lists/payment_list.dart';
import 'package:hashkey/lists/wifi_list.dart';
import 'package:hashkey/provider/data_provider.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:hashkey/services/app.dart';
import 'package:hashkey/shared/widgets/alert.dart';
import 'package:hashkey/shared/widgets/appbar.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class Lists extends StatefulWidget {
  const Lists({ Key? key }) : super(key: key);

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  bool isLoading = false;
  late List myArray = [];
  late Map arg;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, (){
      setState(() {
        arg = ModalRoute.of(context)?.settings.arguments as Map;
      });
      initCredential(arg);
    });
  }

  Future initCredential(Map data) async {
    setState(() => isLoading = true,);
    List array = Provider.of<DataProvider>(context, listen: false).getCategoryType(data['type']);
    setState( () => myArray = array );
    if(array.isEmpty){
      String endpoint = getEndpoint(data);
      Map result = await App().getCredentials(endpoint);
      setState(() => isLoading = false,);
      if(result['success']){
        switch (data['type']) {
          case 'password':
            Provider.of<DataProvider>(context, listen: false).setPasswords(result['data']);
            break;
          case 'wifi':
            Provider.of<DataProvider>(context, listen: false).setWifis(result['data']);
            break;
          case 'payment':
            Provider.of<DataProvider>(context, listen: false).setPayments(result['data']);
            break;
        }
      }
      else{
        if(result['status'] == 401){
          showDialog(
            barrierDismissible: false,
            context: context, builder: (_) => 
            CustomAlert(message: result['message'], type: 'error', statusType: 'error', callback: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false))
          );
        }
        else{
          showDialog(
            context: context, builder: (_) => 
            CustomAlert(message: result['message'], type: 'error', statusType: null, callback: () => Navigator.pop(context))
          );
        }
      }
    }
    //TODO: check if the localdata and server data is on the same length s
    else{
      setState(() {
        isLoading = false;
      });
    }
  }

  String getEndpoint(Map data){
    String endpoint = '';
    switch (data['type']) {
      case 'password':
        endpoint = 'passwords';
        break;
      case 'wifi':
        endpoint = 'wifis';
        break;
      case 'notes':
        endpoint = 'notes';
        break;
      case 'payment':
        endpoint = 'cards';
        break;
      case 'license':
        endpoint = 'licenses';
        break;
      case 'contact':
        endpoint = 'contacts';
        break;
    }
    return endpoint;
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Map;
    final theme = Provider.of<ThemeProvider>(context).theme;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.w),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 50.h,),
                CustomHeader(title: arg['name'], withBackButton: true),
                SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: (){}, 
                      icon: const Icon(Icons.sort)
                    ),
                    IconButton(
                      onPressed: (){}, 
                      icon: const Icon(Icons.refresh_rounded)
                    )
                  ],
                ),
                SizedBox(height: 5.h,),
                SizedBox(
                  height: 470.h,
                  // color: Colors.amber,
                  child: widgetType(isLoading, myArray, arg['type'], theme),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetType(bool state, List array, String type, String theme){
    // print(array);
    if(state){
      return SkeletonTheme(
        themeMode: theme == 'dark' ? ThemeMode.dark : ThemeMode.light,
        //TODO: Configure skeleton listview on each category
        child: SkeletonListView(padding: EdgeInsets.zero)
      );
    }
    else if(!state && array.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(FontAwesomeIcons.folderOpen, size: 40,),
            SizedBox(height: 20.h,),
            Text(
              'Your vault is empty',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      );
    }
    else{
      print(array);
      return listViewType(type);
    }
  }

  Widget listViewType(String type){
    var arrayList = Provider.of<DataProvider>(context, listen: false).getCategoryType(type);
    if(type == 'password'){
      return PasswordList(arrayList: arrayList);
    }
    else if(type == 'wifi'){
      return WifiList(arrayList: arrayList);
    }
    else if(type == 'payment'){
      return PaymentList(arrayList: arrayList);
    }
    //TODO - add listviews on license, notes and contacts
    else{
      return Container();
    }
  }
}

