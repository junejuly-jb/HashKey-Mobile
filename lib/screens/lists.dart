import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/models/password.dart';
import 'package:hashkey/models/wifi.dart';
import 'package:hashkey/provider/data_provider.dart';
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
            Provider.of<DataProvider>(context, listen: false).getPasswords(result['data']);
            break;
          case 'wifi':
            Provider.of<DataProvider>(context, listen: false).getWifis(result['data']);
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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 240, 247, 1),
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
                  child: widgetType(isLoading, myArray, arg['type']),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetType(bool state, List array, String type){
    if(state){
      return SkeletonListView(padding: EdgeInsets.zero);
    }
    else if(!state && array.isEmpty){
      return const Text('No Data Found');
    }
    else{
      return listViewType(type);
    }
  }

  Widget listViewType(String type){
    var arrayList = Provider.of<DataProvider>(context, listen: false).getCategoryType(type);
    if(type == 'password'){
      return ListView.builder(
        shrinkWrap: true,
        itemCount: arrayList.length,
        itemBuilder: (BuildContext context, int index){
          Password password = arrayList[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: InkWell(
              splashColor: Colors.blue[200],
              onTap: () => print('Test'),
              child: ListTile(
                minLeadingWidth: 55.w,
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100.r)
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 15.r,
                    child: FaIcon(FontAwesomeIcons.lock, color: Colors.grey[700], 
                    size: 20,), 
                    
                  )
                ),
                title: Text(
                  password.logName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
            ),
          );
        }
      );
    }
    else{
      return ListView.builder(
        shrinkWrap: true,
        itemCount: arrayList.length,
        itemBuilder: (BuildContext context, int index){
          Wifi wifi = arrayList[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: InkWell(
              splashColor: Colors.blue[200],
              onTap: () => print('Test'),
              child: ListTile(
                minLeadingWidth: 55.w,
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100.r)
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 15.r,
                    child: FaIcon(FontAwesomeIcons.wifi, color: Colors.grey[700], 
                    size: 20,), 
                    
                  )
                ),
                title: Text(
                  wifi.wifiSsid,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
            ),
          );
        }
      );
    }
  }
}

