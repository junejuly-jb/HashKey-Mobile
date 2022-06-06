import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class BottomView extends StatelessWidget {
  final String appState;
  final Function setAppState;
  const BottomView({
    Key? key,
    required this.appState,
    required this.setAppState
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromRGBO(241, 240, 247, 1),
      elevation: 20.0,
      shape: const CircularNotchedRectangle(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            Expanded(
              // padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: IconButton(onPressed: () => setAppState('home'), 
                icon: SvgPicture.asset(
                  'lib/assets/bottom_appbar_icons/${appState == 'home'? 'home' : 'home-outlined'}.svg', 
                  width: 19.w, 
                  height: 17.h,
                  color: appState == 'home' ? const Color.fromRGBO(106, 17, 203, 1) : null,
                )
              ),
            ),
            Expanded(
              child: IconButton(onPressed: () => setAppState('generate'), 
                icon: SvgPicture.asset(
                  'lib/assets/bottom_appbar_icons/${appState == 'generate' ? 'generate' : 'generate-outlined'}.svg', 
                  width: 19.w, 
                  height: 17.h,
                  color: appState == 'generate' ? const Color.fromRGBO(106, 17, 203, 1) : null,
                )
              ),
            ),
            const Spacer(),
            Expanded(
               child: IconButton(onPressed: () => setAppState('qrcode'), 
                icon: SvgPicture.asset(
                  'lib/assets/bottom_appbar_icons/${appState == 'qrcode' ? 'qrcode' : 'qrcode-outlined'}.svg', 
                  width: 19.w, 
                  height: 17.h,
                  color: appState == 'qrcode' ? const Color.fromRGBO(106, 17, 203, 1) : null,
                )
              ),
            ),
            Expanded(
               child: IconButton(onPressed: () => setAppState('settings'), 
                icon: SvgPicture.asset(
                  'lib/assets/bottom_appbar_icons/${appState == 'settings' ? 'settings' : 'settings-outlined'}.svg', 
                  width: 19.w, 
                  height: 17.h,
                  color: appState == 'settings' ? const Color.fromRGBO(106, 17, 203, 1) : null,
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}