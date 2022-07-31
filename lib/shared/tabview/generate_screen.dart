import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/provider/app_state_provider.dart';
import 'package:hashkey/provider/user_provider.dart';
import 'package:hashkey/shared/widgets/appbar.dart';
import 'package:hashkey/shared/widgets/large_buttons.dart';
import 'package:hashkey/shared/widgets/small_buttons.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/setting_tile.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({ Key? key }) : super(key: key);

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  double len = 10.0;
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);
    final theme = Provider.of<UserProvider>(context).theme;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.h,),
            const CustomHeader(title: 'Generate', withBackButton: false),
            SizedBox(height: 10.h,),
            Text('Password', style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),),
            SizedBox(height: 5.h,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: theme == 'light' ? Colors.white : const Color.fromRGBO(54, 54, 54, 1)
              ),
              height: 64.h,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(appState.randomString == '' ? '-' : appState.randomString, style: Theme.of(context).textTheme.headline2,),
                ],
              ),
            ),
            SizedBox(height: 5.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SmallButton(icon: FontAwesomeIcons.solidCopy, callback: (){
                  Clipboard.setData(ClipboardData(text: appState.randomString)).then((value) => Fluttertoast.showToast(msg: 'Text copied successfully!'));
                })
              ],
            ),
            // SizedBox(height: 15.h,),
            Text('Options', style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),),
            SizedBox(height: 10.h,),
            SettingsTile(
              settingType: 'length',
              backgroundColor: const Color.fromRGBO(251, 237, 231, 1), 
              foregroundColor: const Color.fromRGBO(211, 130, 95, 1),  
              icon: FontAwesomeIcons.penRuler, 
              title: 'String length', subtitle: appState.passLength.round().toString(), actionType: 'button',
              stringVal: null, boolVal: null,
              callback: () => showDialog(context: context, builder: (_){
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  content: StatefulBuilder(
                    builder:(BuildContext context, StateSetter setState){
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(context.watch<AppStateProvider>().passLength.round().toString(), style: TextStyle( fontSize: 20.sp, fontWeight: FontWeight.bold), ),
                          Slider(
                            value: context.watch<AppStateProvider>().passLength,
                            min: 8,
                            max: 15,
                            divisions: 7,
                            label: context.watch<AppStateProvider>().passLength.round().toString(),
                            onChanged: (double value) {
                              context.read<AppStateProvider>().updatePassLength(value);
                            },
                          )
                        ],
                      );
                    }
                  ),
                );
              }),
            ),
            SizedBox(height: 10.h,),
            SettingsTile(
              settingType: 'uppercase',
              backgroundColor: const Color.fromRGBO(236, 232, 255, 1), 
              foregroundColor: const Color.fromRGBO(82, 53, 223, 1),
              icon: Icons.abc, 
              title: 'Uppercase', subtitle: null, actionType: 'switch',
              stringVal: null, boolVal: appState.upperCaseState,
              callback: (val) => appState.updateBoolState('upperCaseState', val),
            ),
            SizedBox(height: 10.h,),
            SettingsTile(
              settingType: 'lowercase',
              backgroundColor: const Color.fromRGBO(236, 232, 255, 1), 
              foregroundColor: const Color.fromRGBO(82, 53, 223, 1),
              icon: Icons.abc, 
              title: 'Lowercase', subtitle: null, actionType: 'switch',
              stringVal: null, boolVal: appState.lowerCaseState,
              callback: (val) => appState.updateBoolState('lowerCaseState', val),
            ),
            SizedBox(height: 10.h,),
            SettingsTile(
              settingType: 'numbers',
              backgroundColor: const Color.fromRGBO(236, 247, 254, 1), 
              foregroundColor: const Color.fromRGBO(66, 171, 237, 1), 
              icon: Icons.numbers, 
              title: 'Numbers', subtitle: null, actionType: 'switch',
              stringVal: null, boolVal: appState.numberState,
              callback: (val) => appState.updateBoolState('numberState', val),
            ),
            SizedBox(height: 10.h,),
            SettingsTile(
              settingType: 'symbols',
              backgroundColor: const Color.fromRGBO(254, 231, 240, 1), 
              foregroundColor: const Color.fromRGBO(197, 45, 90, 1),
              icon: FontAwesomeIcons.exclamation, 
              title: 'Symbols', subtitle: null, actionType: 'switch',
              stringVal: null, boolVal: appState.symbolState,
              callback: (val) => appState.updateBoolState('symbolState', val),
            ),
            SizedBox(height: 25.h,),
            XtraLargeButton(title: 'Generate', isGradient: true, callback: () => appState.generateRandomString())
          ],
        ),
      ),
    );
  }
}