import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/app_state_provider.dart';
import 'package:provider/provider.dart';



class BottomView extends StatelessWidget {
  const BottomView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppStateProvider>(context);
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
              child: IconButton(onPressed: () => app.updateStringState('_tabState', 'home'), 
                icon: SvgPicture.asset(
                  'lib/assets/bottom_appbar_icons/${app.appState == 'home'? 'home' : 'home-outlined'}.svg', 
                  width: 19.w, 
                  height: 17.h,
                  color: app.appState == 'home' ? const Color.fromRGBO(106, 17, 203, 1) : null,
                )
              ),
            ),
            Expanded(
              child: IconButton(onPressed: () => app.updateStringState('_tabState','generate'), 
                icon: SvgPicture.asset(
                  'lib/assets/bottom_appbar_icons/${app.appState == 'generate' ? 'generate' : 'generate-outlined'}.svg', 
                  width: 19.w, 
                  height: 17.h,
                  color: app.appState == 'generate' ? const Color.fromRGBO(106, 17, 203, 1) : null,
                )
              ),
            ),
            const Spacer(),
            Expanded(
               child: IconButton(onPressed: () => app.updateStringState('_tabState', 'qrcode'), 
                icon: SvgPicture.asset(
                  'lib/assets/bottom_appbar_icons/${app.appState == 'qrcode' ? 'qrcode' : 'qrcode-outlined'}.svg', 
                  width: 19.w, 
                  height: 17.h,
                  color: app.appState == 'qrcode' ? const Color.fromRGBO(106, 17, 203, 1) : null,
                )
              ),
            ),
            Expanded(
               child: IconButton(onPressed: () => app.updateStringState('_tabState', 'settings'), 
                icon: SvgPicture.asset(
                  'lib/assets/bottom_appbar_icons/${app.appState == 'settings' ? 'settings' : 'settings-outlined'}.svg', 
                  width: 19.w, 
                  height: 17.h,
                  color: app.appState == 'settings' ? const Color.fromRGBO(106, 17, 203, 1) : null,
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}