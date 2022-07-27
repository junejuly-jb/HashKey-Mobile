import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/services/app.dart';
import 'package:hashkey/shared/widgets/alert.dart';
import 'package:hashkey/shared/widgets/appbar.dart';
import 'package:skeletons/skeletons.dart';

class Lists extends StatefulWidget {
  const Lists({ Key? key }) : super(key: key);

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  bool isLoading = false;
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
    // String dataType = getProviderData(data['type']);
    // final provider = Provider.of<DataProvider>(context, listen: false);
    // List arrays = provider;

    // todo: GET DATAPROVIDER DATA VIA FUNCTION 
    String endpoint = getEndpoint(data);
    Map result = await App().getCredentials(endpoint);
    if(result['success']){
      print('success');
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
    print(result);
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


  String getProviderData(String type){
    String datatype = '';
    switch (type) {
      case 'password':
        datatype = 'passwords';
        break;
      case 'wifi':
        datatype = 'wifis';
        break;
      case 'notes':
        datatype = 'notes';
        break;
      case 'payment':
        datatype = 'cards';
        break;
      case 'license':
        datatype = 'licenses';
        break;
      case 'contact':
        datatype = 'contacts';
        break;
    }
    return datatype;
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Map;
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
                SizedBox(height: 25.h,),
                SizedBox(
                  height: 470.h,
                  // color: Colors.amber,
                  child: isLoading ? SkeletonListView(
                    padding: EdgeInsets.zero,
                  ) : const Text('Hello'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}