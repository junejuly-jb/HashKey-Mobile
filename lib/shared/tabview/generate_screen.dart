import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/provider/app_state_provider.dart';
import 'package:hashkey/shared/widgets/appbar.dart';
import 'package:hashkey/shared/widgets/large_buttons.dart';
import 'package:hashkey/shared/widgets/small_buttons.dart';
import 'package:provider/provider.dart';

import '../widgets/setting_tile.dart';

class GenerateScreen extends StatelessWidget {
  const GenerateScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h,),
            const CustomHeader(title: 'Generate', withBackButton: false),
            SizedBox(height: 15.h,),
            Text('Password', style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),),
            SizedBox(height: 5.h,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white
              ),
              height: 64.h,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(appState.randomString == '' ? '-' : appState.randomString, style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold, letterSpacing: 2),),
                ],
              ),
            ),
            SizedBox(height: 5.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SmallButton(icon: FontAwesomeIcons.solidCopy, callback: () => print('hello'))
              ],
            ),
            SizedBox(height: 20.h,),
            Text('Options', style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),),
            SizedBox(height: 10.h,),
            SettingsTile(
              settingType: 'length',
              backgroundColor: const Color.fromRGBO(251, 237, 231, 1), 
              foregroundColor: const Color.fromRGBO(211, 130, 95, 1),  
              icon: FontAwesomeIcons.penRuler, 
              title: 'String length', subtitle: appState.passLength, actionType: 'button',
              stringVal: null, boolVal: null,
              callback: null,
            ),
            SizedBox(height: 10.h,),
            SettingsTile(
              settingType: 'uppercase',
              backgroundColor: const Color.fromRGBO(236, 232, 255, 1), 
              foregroundColor: const Color.fromRGBO(82, 53, 223, 1),
              icon: Icons.abc, 
              title: 'Uppercase', subtitle: null, actionType: 'switch',
              stringVal: null, boolVal: appState.upperCaseState,
              callback: (val) => appState.updateGenerateSetting('upperCaseState', 'bool', null, val),
            ),
            SizedBox(height: 10.h,),
            SettingsTile(
              settingType: 'lowercase',
              backgroundColor: const Color.fromRGBO(236, 232, 255, 1), 
              foregroundColor: const Color.fromRGBO(82, 53, 223, 1),
              icon: Icons.abc, 
              title: 'Lowercase', subtitle: null, actionType: 'switch',
              stringVal: null, boolVal: appState.lowerCaseState,
              callback: (val) => appState.updateGenerateSetting('lowerCaseState', 'bool', null, val),
            ),
            SizedBox(height: 10.h,),
            SettingsTile(
              settingType: 'numbers',
              backgroundColor: const Color.fromRGBO(236, 247, 254, 1), 
              foregroundColor: const Color.fromRGBO(66, 171, 237, 1), 
              icon: Icons.numbers, 
              title: 'Numbers', subtitle: null, actionType: 'switch',
              stringVal: null, boolVal: appState.numberState,
              callback: (val) => appState.updateGenerateSetting('numberState', 'bool', null, val),
            ),
            SizedBox(height: 10.h,),
            SettingsTile(
              settingType: 'symbols',
              backgroundColor: const Color.fromRGBO(254, 231, 240, 1), 
              foregroundColor: const Color.fromRGBO(197, 45, 90, 1),
              icon: FontAwesomeIcons.exclamation, 
              title: 'Symbols', subtitle: null, actionType: 'switch',
              stringVal: null, boolVal: appState.symbolState,
              callback: (val) => appState.updateGenerateSetting('symbolState', 'bool', null, val),
            ),
            SizedBox(height: 15.h,),
            XtraLargeButton(title: 'Generate', callback: () => appState.generateRandomString())
          ],
        ),
      ),
    );
  }
}