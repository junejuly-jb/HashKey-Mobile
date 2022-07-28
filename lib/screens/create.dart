import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hashkey/provider/data_provider.dart';
import 'package:hashkey/services/app.dart';
import 'package:hashkey/shared/forms/password.dart';
import 'package:hashkey/shared/forms/payment.dart';
import 'package:hashkey/shared/forms/wifi.dart';
import 'package:hashkey/shared/widgets/alert.dart';
import 'package:hashkey/shared/widgets/appbar.dart';
import 'package:hashkey/shared/widgets/large_buttons.dart';
import 'package:provider/provider.dart';

class CreateNew extends StatefulWidget {
  const CreateNew({Key? key}) : super(key: key);

  @override
  State<CreateNew> createState() => _CreateNewState();
}

class _CreateNewState extends State<CreateNew> {

  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();

  String constantString = "WEP";
  String string2 = "";
  String string3 = "";

  bool bool1 = false;
  bool bool2 = false;

  Future onSaveCredential(String type) async {
    showDialog(
      barrierDismissible: false,
      context: context, builder: (_) => 
      CustomAlert(message: 'Adding $type, Please wait', type: 'loading', statusType: null, callback: null)
    );
    Map credData = dataSegregation(type);
    print(credData);
    Map result = await App().saveCredential(credData);
    print(result);
    Navigator.pop(context);
    if(result['success']){
      Map<String, dynamic> recent = result['recent'];
      Provider.of<DataProvider>(context, listen: false).setRecent(recent);
      Provider.of<DataProvider>(context, listen: false).incrementCategoryCount(type.toLowerCase(), 'increment');
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      Fluttertoast.showToast(msg: result['message']);
    }else{
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
          CustomAlert(message: result['message'], type: 'error', statusType: 'error', callback: () => Navigator.pop(context))
        );
      }
    }
  }

  Map dataSegregation(String type){
    Map data = {};
    switch (type) {
      case 'Password':
        data['endpoint'] = 'add-password';
        data['l_logname'] = controller1.text;
        data['l_website'] = '';
        data['l_url'] = controller2.text;
        data['l_user'] = controller3.text;
        data['l_pass'] = controller4.text;
        break;
      case 'Wifi':
        data['endpoint'] = 'add-wifi';
        data['w_ssid'] = controller1.text;
        data['w_pass'] = controller2.text;
        data['w_security'] = constantString;
        data['w_status'] = bool1.toString();
        break;
    }
    return data;
  }

  changeS1(String val){
    setState(() => constantString = val);
  }

  changeB1(bool val){
    setState(() => bool1 = val);
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as String;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(241, 240, 247, 1),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                children: [
                  SizedBox(height: 50.h,),
                  CustomHeader(title: 'Add New $arg', withBackButton: true),
                  SizedBox(height: 40.h,),
                  formType(arg, controller1, controller2, controller3, controller4, constantString, string2, bool1, bool2)
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
          child: XtraLargeButton(title: 'Save', callback: () => onSaveCredential(arg), isGradient: true),
        ),
      ),
      
    );
  }

  Widget formType(
  String type, 
  TextEditingController c1,  
  TextEditingController c2,  
  TextEditingController c3,  
  TextEditingController c4,
  String constString, String s2, bool bool1, bool bool2
){
  print(type);
  if(type == 'Password'){
    return PasswordInput(
      controller1: c1,
      controller2: c2,
      controller3: c3,
      controller4: c4,
    );
  }
  else if(type == 'Wifi'){
    return WifiForm(
      controller1: c1, 
      controller2: c2,
      ddValue: constString, 
      isVisible: bool1,
      callback: (data){
        changeS1(data);
      },
      callback2: (data){
       changeB1(data);
      },
    );
  }
  else if(type == 'Payment'){
    return CardForm(
      controller1: c1,
      controller2: c2,
      controller3: c3,
    );
  }
  else{
    return Container();
  }
}
}

