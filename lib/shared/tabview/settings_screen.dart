import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/app_state_provider.dart';
import 'package:hashkey/provider/data_provider.dart';
import 'package:hashkey/provider/user_provider.dart';
import 'package:hashkey/shared/widgets/alert.dart';
import 'package:hashkey/shared/widgets/appbar.dart';
import 'package:hashkey/shared/widgets/setting_tile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h,),
            const CustomHeader(title: 'Settings', withBackButton: false),
            SizedBox(height: 30.h,),
            Text('Account', style: Theme.of(context).textTheme.headline2,),
            SizedBox(height: 22.h,),
            Row(
              children: [
                profileType(user.user['profileType'], user.user['profile']),
                SizedBox(width: 20.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.user['name'], style: Theme.of(context).textTheme.bodyText1,),
                    Text('Personal Info', style: Theme.of(context).textTheme.subtitle1,),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 50.w,
                  height: 40.h,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: user.theme == 'light' ? 
                      MaterialStateProperty.all<Color>(Colors.white) : MaterialStateProperty.all<Color>(const Color.fromRGBO(54, 54, 54, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        )
                      ),
                      elevation: MaterialStateProperty.resolveWith<double>(  // As you said you dont need elevation. I'm returning 0 in both case
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return 0;
                          }
                          return 0; // Defer to the widget's default.
                        },
                      ),
                    ),
                    onPressed: (){}, child: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.grey,)
                  ),
                )
              ],
            ),
            SizedBox(height: 22.h,),
            Text('Preferences', style: Theme.of(context).textTheme.headline2,),
            SizedBox(height: 22.h,),
            SettingsTile(
              settingType: 'pin',
              backgroundColor: const Color.fromRGBO(251, 237, 231, 1), 
              foregroundColor: const Color.fromRGBO(211, 130, 95, 1), 
              icon: Icons.lock, 
              title: 'Pin', subtitle: null, actionType: 'switch',
              stringVal: null, boolVal: user.user['settings']['pin'],
              callback: (val) => print(val),
            ),
            SizedBox(height: 15.h,),
            SettingsTile(
              settingType: 'timeout',
              backgroundColor: const Color.fromRGBO(236, 247, 254, 1), 
              foregroundColor: const Color.fromRGBO(66, 171, 237, 1), 
              icon: Icons.lock_clock, 
              title: 'Vault Timeout', subtitle: '15 minutes', actionType: 'button',
              stringVal: user.user['settings']['timeout'], boolVal: null,
              callback: null,
            ),
            SizedBox(height: 15.h,),
            SettingsTile(
              settingType: 'timeoutAction',
              backgroundColor: const Color.fromRGBO(236, 232, 255, 1), 
              foregroundColor: const Color.fromRGBO(82, 53, 223, 1), 
              icon: Icons.directions_run_rounded, 
              title: 'Vault Action', subtitle: 'Lock', actionType: 'button',
              stringVal: user.user['settings']['timeoutAction'], boolVal: null,
              callback: null,
            ),
            SizedBox(height: 15.h,),
            SettingsTile(
              settingType: 'easyaccess',
              backgroundColor: const Color.fromRGBO(254, 231, 240, 1), 
              foregroundColor: const Color.fromRGBO(197, 45, 90, 1), 
              icon: Icons.accessibility_new_rounded, 
              title: 'Easy Access', subtitle: null, actionType: 'switch',
              stringVal: null, boolVal: user.user['settings']['easyaccess'],
              callback: (val) => print(val),
            ),
            SizedBox(height: 15.h,),
            SettingsTile(
              settingType: 'easyaccess',
              backgroundColor: const Color.fromRGBO(254, 231, 240, 1), 
              foregroundColor: const Color.fromRGBO(197, 45, 90, 1), 
              icon: user.theme == 'dark' ? Icons.dark_mode : Icons.light, 
              title: 'Dark Mode', subtitle: null, actionType: 'switch',
              stringVal: null, boolVal: user.theme == 'dark' ? true : false,
              callback: (val) => user.setTheme(),
            ),
            SizedBox(height: 15.h,),
            Center(
              child: TextButton(
                onPressed: () async{ 
                final prefs = await SharedPreferences.getInstance();
                String? user = prefs.getString('user');
                if(user != null){
                  Navigator.pushReplacementNamed(context, '/login');
                  Provider.of<UserProvider>(context, listen: false).removeUser();
                  Provider.of<UserProvider>(context, listen: false).removeUserState();
                  Provider.of<DataProvider>(context, listen: false).setEmpty();
                  Provider.of<AppStateProvider>(context, listen: false).setAppStateOnLogout();
                }
                else{
                  CustomAlert(message: 'Unable to log-out', type: 'error', statusType: 'error', callback: () => Navigator.pop(context),);
                }
              }, child: const Text('Logout', style: TextStyle(color: Colors.red),)),
            ),
          ]
        ),
      ),
    );
  }
}

Widget profileType(String type, String profile){
  if(type == 'link'){
    return CircleAvatar(
      child: Text(profile),
      radius: 25.r,
    );
  }
  else if(type == 'base64'){
    return CircleAvatar(
      child: Text(profile),
      radius: 25.r,
    );
  }
  else{
    return CircleAvatar(
      child: Text(profile),
      radius: 25.r,
    );
  }
}