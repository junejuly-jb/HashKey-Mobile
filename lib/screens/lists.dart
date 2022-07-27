import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/data_provider.dart';
import 'package:hashkey/services/app.dart';
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
    String endpoint = getEndpoint(data);
    Map result = await App().getCredentials(endpoint);
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