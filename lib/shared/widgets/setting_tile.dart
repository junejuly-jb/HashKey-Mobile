import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsTile extends StatelessWidget {
  final String settingType;
  final IconData icon;
  final Color backgroundColor, foregroundColor;
  final String title;
  final String? subtitle;
  final String? actionType;
  final String? stringVal;
  final bool? boolVal;
  final Function? callback;
  const SettingsTile({ Key? key,
    required this.settingType,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.actionType,
    required this.stringVal,
    required this.callback,
    required this.boolVal }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: backgroundColor,
          child: Icon(icon, color: foregroundColor,),
          radius: 25.r,
        ),
        SizedBox(width: 20.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyText1,),
            Container(
              child: subtitle != null ? Text(subtitle.toString()) : null,
            )
          ],
        ),
        const Spacer(),
        Container(
          child: actionType == 'button' ? SizedBox(
            width: 50.w,
            height: 40.h,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
              onPressed: () => callback!(), child: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.grey,)
            ),
          ) : 
          CupertinoSwitch(value: boolVal!, onChanged: (val) => callback!(val)),
        )
      ],
    );
  }
}